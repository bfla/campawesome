class CampsitesController < ApplicationController
  require 'net/http'
  before_action :set_campsite, only: [ :edit, :update, :destroy]
  before_action :admin_only, only: [:new, :create, :import, :edit, :update, :destroy ]
  after_action :set_access_control_headers, only: [:search, :resetSearch]

  def search
    zoom = params[:zoom] || 10
    distance = params[:distance] || 30
    coordinates = Geocoder.coordinates(params[:keywords])
    @campsites = Campsite.near(coordinates, distance).includes(:tribes, :taggings).first(50)
    @tribes = Tribe.all
    @tags = Tag.all

    # If the location produces no campsites, try running a text search on the name
    if @campsites.blank?
      @campsites = Campsite.name_search(params[:keywords])
    end

    # Position the map
    if @campsites.blank? 
      @center = coordinates
    else
      @center = Geocoder::Calculations.geographic_center(@campsites)
    end

    if is_mobile_device?
      @href = search_map_campsites_path(params) #Link to corresponding mobile map
    end

    @geojson = Array.new
    @campsites.each { |campsite| @geojson << campsite.geojsonify}
    gon.campsites = @campsites
    gon.geoJson = @geojson
    gon.center = @center
    gon.zoom = zoom
    gon.initTribe = params[:tribe_id] || 0

    respond_to do |format|
      format.html { render layout:"layouts/pages/search", notice: 'I found 2 campsites that look perfect for you.' }
      format.json { render json: @geojson }  # respond with geoJSON object
    end

  end

  def search_map # for mobile devices
    zoom = params[:zoom] || 10
    distance = params[:distance] || 30
    coordinates = Geocoder.coordinates(params[:keywords])
    @campsites = Campsite.near(coordinates, distance).includes(:tribes, :taggings).first(50)
    @tribes = Tribe.all
    @tags = Tag.all

    # If the location produces no campsites, try running a text search on the name
    if @campsites.blank?
      @campsites = Campsite.name_search(params[:keywords])
    end

    # Position the map
    if @campsites.blank? 
      @center = coordinates
    else
      @center = Geocoder::Calculations.geographic_center(@campsites)
    end

    @geojson = Array.new
    @campsites.each { |campsite| @geojson << campsite.geojsonify}
    gon.campsites = @campsites
    gon.geoJson = @geojson
    gon.center = @center
    gon.zoom = zoom
    gon.initTribe = params[:tribe_id] || 0

    @href = search_campsites_path(params) #path to the list results url

    respond_to do |format|
      format.html { render layout:"layouts/application", notice: 'I found 2 campsites that look perfect for you.' }
      format.json { render json: @geojson }  # respond with geoJSON object
    end
  end

  def resetSearch
    zoom = params[:zoom] || 10
    distance = params[:distance] || 30
    coordinates = Geocoder.coordinates(params[:keywords])
    @campsites = Campsite.near(coordinates, distance).includes(:tribes, :taggings).first(50)
    @tribes = Tribe.all
    @tags = Tag.all
    render layout: "layouts/pages/none"
  end

  def contrib
    @campsites = Campsite.name_search(params[:keywords])
    @campsites = Campsite.near( Geocoder.coordinates(params[:keywords])) if @campsites.blank?
    @previous_url = session[:previous_url]
  end
  
  def activities
    @campsite = Campsite.includes(activities: :activity_type).find(params[:id])
    @activity_types  = ActivityType.all
    render layout: "layouts/normal"
  end

  def import
    Campsite.import(params[:file])
    redirect_to root_url, notice:"imported!"
  end

  # GET /campsites
  # GET /campsites.json
  def index
    @campsites = Campsite.all
  end

  # GET /campsites/1
  # GET /campsites/1.json
  def show
    @campsite = Campsite.includes(:photos, :tags, :fees, :beens, :wants, :listeds, reviews: [:rating]).friendly.find(params[:id])
    @activity_types = ActivityType.all
    @nearbys = @campsite.nearbys.limit(10)
    @recommended = Array.new
    if user_signed_in?
      @nearbys.each do |nearby_campsite|
        if nearby_campsite.tribes.include? current_user.tribe
          @recommended << nearby_campsite
        end
      end
    end
    gon.initCenter = [@campsite.latitude, @campsite.longitude]
    gon.geoJson = @campsite.geojsonify
    
    # Try to get google image if the campsite has no photo
    if @campsite.photos.blank?
      gplaces_key = "AIzaSyB9mHzeQJxtkMkn_UkKAOs00Hkg2Y9qKds"
      # run a Google Places search
      gplace_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{@campsite.latitude},#{@campsite.longitude}&radius=8000&sensor=false&key=#{gplaces_key}"
      @place_urlness = gplace_url
      gplace_response = Net::HTTP.get_response(URI.parse(gplace_url))
      gplaces = JSON.parse(gplace_response.body)
      puts gplaces

      # test if Google has any photos and if so fetch it
      @goog_photo_bool = false
      @photo_license = nil
      gplaces["results"].each do |gplace|
        if gplace["photos"] and gplace["types"]
          acceptable_types = ["park", "campground", "natural_feature", "rv_park", "locality", "point_of_interest"]
          gplace["types"].each do |type|
            if acceptable_types.include? type
              @goog_photo_bool = true
              photo = gplace["photos"].first
              @photo_license = photo["html_attributions"] if photo["html_attributions"]
              photo_ref = photo["photo_reference"]
              target_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{photo_ref}&sensor=true&key=#{gplaces_key}"
              @url = target_url
              response = Net::HTTP.get_response(URI.parse(target_url))
              @goog_img = response.body
              break # since we now have a photo, break the loop
            end
          end
        end
      end
    else
      @goog_photo_bool = false
    end

    render(layout: "layouts/normal")
  end

  # GET /campsites/new
  def new
    @campsite = Campsite.new
  end

  # GET /campsites/1/edit
  def edit
  end

  # POST /campsites
  # POST /campsites.json
  def create
    @campsite = Campsite.new(campsite_params)
    respond_to do |format|
      if @campsite.save
        format.html { redirect_to @campsite, notice: 'Campsite was successfully created.' }
        format.json { render action: 'show', status: :created, location: @campsite }
      else
        format.html { render action: 'new' }
        format.json { render json: @campsite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campsites/1
  # PATCH/PUT /campsites/1.json
  def update
    respond_to do |format|
      if @campsite.update(campsite_params)
        format.html { redirect_to @campsite, notice: 'Campsite was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @campsite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campsites/1
  # DELETE /campsites/1.json
  def destroy
    @campsite.destroy
    respond_to do |format|
      format.html { redirect_to campsites_url }
      format.json { head :no_content }
    end
  end

  private
    def admin_only
      redirect_to forbidden_path unless current_user && current_user.is_admin
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_campsite
      @campsite = Campsite.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campsite_params
      params.require(:campsite).permit(:name, :description, :org, 
        :res_phone, :camp_phone, :res_url, :camp_url, :reservable, 
        :walkin, :latitude, :longitude, :state_id, :city_id)
    end

    def set_access_control_headers
      headers['Access-Control-Allow-Origin'] = "http://gentle-ocean-6036.herokuapp.com"
      headers['Access-Control-Request-Method'] = %w{GET POST OPTIONS}.join(",")
    end
end
