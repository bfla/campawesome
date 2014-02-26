class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

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
    @photo =  Photo.create(photo_params)
    @photo.user_id = current_user.id
    #@photo = Photo.create(campsite_id:params[:campsite_id], user_id:current_user.id)
    #@photo.title = params[:title] unless params[:title].blank?
    #@photo.caption = params[:caption] unless params[:caption].blank?
    #@photo.state_id = params[:state_id] unless params[:state_id].blank?
    #@photo.city_id = params[:city_id] unless params[:city_id].blank?


    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
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
end
