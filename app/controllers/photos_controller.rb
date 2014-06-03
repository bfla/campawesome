class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :verify_user, only: [:destroy, :update]
  before_action :admin_only, only: [:new]

  # GET /photos
  # GET /photos.json
  def index
    #@photos = Photo.all
    if user_signed_in?
      @photos = current_user.photos
      render layout:"layouts/twoColumn"
    else
      redirect_to new_user_session_path
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    #@photo = Photo.create(user_id:current_user.id, photo_file:params[:photo_file])
    @photo = Photo.create(photo_params)
    @photo.user_id = current_user.id
    #@photo.title = params[:title] unless params[:title].blank?
    #@photo.caption = params[:caption] unless params[:caption].blank?
    #@photo.camption = params[:campsite_id] unless params[:campsite_id].blank?
    #@photo.state_id = params[:state_id] unless params[:state_id].blank?
    #@photo.city_id = params[:city_id] unless params[:city_id].blank?
    #@photo.destination_id = params[:destination_id] unless params[:destination_id].blank?
    #@photo.license_type = params[:license_type] unless params[:license_type].blank?
    #@photo.license_text = params[:license_text] unless params[:license_text].blank?
    ##@photo =  Photo.create(photo_params)
    ##@photo.user_id = current_user.id
    #@photo = Photo.create(campsite_id:params[:campsite_id], user_id:current_user.id)
    #@photo.title = params[:title] unless params[:title].blank?
    #@photo.caption = params[:caption] unless params[:caption].blank?
    #@photo.state_id = params[:state_id] unless params[:state_id].blank?
    #@photo.city_id = params[:city_id] unless params[:city_id].blank?
    #@photo.photo_file = params[:photo_file] unless params[:photo_file].blank?


    respond_to do |format|
      if @photo.save
        if @photo.campsite.blank?
          format.html { redirect_to session[:previous_url], notice: 'Photo was successfully added. You just earned some coins and helped your fellow campers.'}
        elsif user_signed_in? && current_user.is_admin
          format.html { redirect_to @photo.campsite }
        else
          format.html { redirect_to session[:previous_url] }
        end
        #format.html { redirect_to @photo, notice: 'Photo was successfully added.' }
        format.json { render action: 'show', status: :created, location: @photo }
      else
        format.html { render action: 'new' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.permit(:photo, :title, :license_type, :license_text, :campsite_id, :city_id, :state_id, :destination_id, :caption, :photo_file)
    end

    def verify_user
      redirect_to forbidden_path unless user_signed_in? && @photo.user_id == current_user.id
    end

    def admin_only
      redirect_to forbidden_path unless current_user && current_user.is_admin
    end
end
