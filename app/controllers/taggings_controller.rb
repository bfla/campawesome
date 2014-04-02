class TaggingsController < ApplicationController
  before_action :set_tagging, only: [:show, :edit, :update, :destroy]
  before_action :admin_only

  # Import CSV file
  def import
    Tagging.import(params[:file])
    redirect_to root_url, notice:"imported!"
  end

  # GET /taggings
  # GET /taggings.json
  def index
    @taggings = Tagging.all
  end

  # GET /taggings/1
  # GET /taggings/1.json
  def show
  end

  # GET /taggings/new
  def new
    @tagging = Tagging.new
  end

  # GET /taggings/1/edit
  def edit
  end

  # POST /taggings
  # POST /taggings.json
  def create
    @tagging = Tagging.new(tagging_params)

    respond_to do |format|
      if @tagging.save
        format.html { redirect_to @tagging, notice: 'Tagging was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tagging }
      else
        format.html { render action: 'new' }
        format.json { render json: @tagging.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /taggings/1
  # PATCH/PUT /taggings/1.json
  def update
    respond_to do |format|
      if @tagging.update(tagging_params)
        format.html { redirect_to @tagging, notice: 'Tagging was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tagging.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /taggings/1
  # DELETE /taggings/1.json
  def destroy
    @tagging.destroy
    respond_to do |format|
      format.html { redirect_to taggings_url }
      format.json { head :no_content }
    end
  end

  private
    def admin_only
      redirect_to forbidden_path unless user_signed_in? && current_user.is_admin
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_tagging
      @tagging = Tagging.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tagging_params
      params.require(:tagging).permit(:campsite_id, :tag_id, :user_id)
    end
end
