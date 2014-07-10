class CitiesController < ApplicationController
  before_action :set_city, only: [ :edit, :update, :destroy]
  before_action :admin_only, only: [:new, :create, :import, :edit, :update, :destroy ]

  def browse
    @city = City.includes(campsites: [ :ratings, :tribes] ).friendly.find(params[:id])
    @tribes = Tribe.all
    gon.campsites = @city.campsites.to_json
    gon.zoom = @city.zoom
    gon.latitude = @city.latitude
    gon.longitude = @city.longitude
    gon.initTribe = params[:tribe_id] || 0
    render(layout: "layouts/guide")
  end

  # GET /cities
  # GET /cities.json
  def index
    @cities = City.all
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
    @city = City.includes(:photos, campsites: [ :ratings, {vibes: :tribe}] ).friendly.find(params[:id])
    @tribes = Tribe.all
    render(layout: "layouts/guide")
    gon.zoom = @city.zoom
    gon.latitude = @city.latitude
    gon.longitude = @city.longitude
  end

  # GET /cities/new
  def new
    @city = City.new
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  # POST /cities.json
  def create
    @city = City.new(city_params)

    respond_to do |format|
      if @city.save
        format.html { redirect_to @city, notice: 'City was successfully created.' }
        format.json { render action: 'show', status: :created, location: @city }
      else
        format.html { render action: 'new' }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to @city, notice: 'City was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to cities_url }
      format.json { head :no_content }
    end
  end

  private
    def admin_only
      redirect_to forbidden_path unless current_user && current_user.is_admin
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:name, :description, :latitude, :longitude, :zoom, :state_id, :tribe_id)
    end
end
