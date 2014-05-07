class CampsitesController < ApplicationController
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
    @nearbys = @campsite.nearbys.limit(5)
    gon.initCenter = [@campsite.latitude, @campsite.longitude]
    gon.geoJson = @campsite.geojsonify
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
