class CampsitesController < ApplicationController
  require 'net/http'
  before_action :set_campsite, only: [ :edit, :update, :destroy]
  before_action :admin_only, only: [:new, :create, :import, :edit, :update, :destroy, :chlite_export ]
  after_action :set_access_control_headers, only: [:search, :resetSearch]

  def search
    @campsites, zoom, distance, coordinates = Campsite.map_search(params[:keywords], params[:zoom], params[:distance])
    @tribes = Tribe.all
    @tags = Tag.all

    # Position the map
    @campsites.blank? ? @center = coordinates : @center = Geocoder::Calculations.geographic_center(@campsites)
    if is_mobile_device? # Mobile device view needs a different url
      @href = search_map_campsites_path(params) #Link to corresponding mobile map
    end
    # Create JSON data
    @geojson = Array.new
    @campsites.each { |campsite| @geojson << campsite.geojsonify}
    gon.campsites = @campsites
    gon.geoJson = @geojson
    gon.center = @center
    gon.zoom = zoom
    gon.initTribe = params[:tribe_id] || 0

    respond_to do |format|
      format.html { render layout:"layouts/pages/search" }
      format.json { render json: @geojson }  # respond with geoJSON object
    end

  end

  def search_map # for mobile devices
    zoom = params[:zoom] || 10
    distance = params[:distance] || 30
    coordinates = Geocoder.coordinates(params[:keywords])
    @campsites = Campsite.near(coordinates, distance).includes(:tribes, :taggings, :city, :state).first(50)
    @tribes = Tribe.all
    @tags = Tag.all

    # If the location produces no campsites, try running a text search on the name
    if @campsites.blank?
      @campsites = Campsite.name_search(params[:keywords])
    end

    # Position the map
    @campsites.blank? ? @center = coordinates : @center = Geocoder::Calculations.geographic_center(@campsites)

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
    @campsites = Campsite.near(coordinates, distance).includes(:tribes, :taggings, :city, :state).first(50)
    @tribes = Tribe.all
    @tags = Tag.all
    render layout: "layouts/pages/none"
  end

  def contrib
    @campsites = Campsite.name_search(params[:keywords])
    @campsites ||= Campsite.near( Geocoder.coordinates(params[:keywords]))
    @previous_url = session[:previous_url] || home_path
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

  def chlite_export
    @campsites = Campsite.includes(:taggings, :vibes).all
    cg_csv = Campsite.to_chlite_csv(@campsites)
    respond_to do |format|
      format.csv {send_data cg_csv}
    end 
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
    @recommended = Campsite.get_recommended(@nearbys, current_user) if user_signed_in? && current_user.tribe
    gon.initCenter = [@campsite.latitude, @campsite.longitude]
    gon.geoJson = @campsite.geojsonify
    
    # Try to get google image if the campsite has no photo
    if @campsite.photos.blank?
      @goog_photo_bool, @photo_license, @goog_img_url = @campsite.get_google_image
    else
      @goog_photo_bool = false
      puts "campsite has photos"
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
        :walkin, :latitude, :longitude, :state_id, :city_id, :email)
    end

    def set_access_control_headers
      headers['Access-Control-Allow-Origin'] = "http://gentle-ocean-6036.herokuapp.com"
      headers['Access-Control-Request-Method'] = %w{GET POST OPTIONS}.join(",")
    end
end
