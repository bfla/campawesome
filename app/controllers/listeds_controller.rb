class ListedsController < ApplicationController
  before_action :set_listed, only: [:show, :edit, :update, :destroy]

  # GET /listeds
  # GET /listeds.json
  def index
    @listeds = Listed.all
  end

  # GET /listeds/1
  # GET /listeds/1.json
  def show
  end

  # GET /listeds/new
  def new
    @listed = Listed.new
  end

  # GET /listeds/1/edit
  def edit
  end

  # POST /listeds
  # POST /listeds.json
  def create
    campsite = Campsite.find(params[:campsite_id])
    if campsite.listeds.where(list_id:params[:list_id]).blank?
      @listed = campsite.listeds.create(list_id:params[:list_id])
    else
      @listed = campsite.listeds.where(list_id:params[:list_id])
    end

    respond_to do |format|
      if @listed.save
        format.html { redirect_to session[:previous_url], notice: 'Listed was successfully created.' }
        format.json { render action: 'show', status: :created, location: @listed }
      else
        format.html { render action: 'new' }
        format.json { render json: @listed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listeds/1
  # PATCH/PUT /listeds/1.json
  def update
    respond_to do |format|
      if @listed.update(listed_params)
        format.html { redirect_to session[:previous_url], notice: 'Listed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @listed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listeds/1
  # DELETE /listeds/1.json
  def destroy
    @listed.destroy
    respond_to do |format|
      format.html { redirect_to session[:previous_url] }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listed
      @listed = Listed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listed_params
      params.permit(:listed, :list_id, :listable_id, :listable_type, :campsite_id)
    end
end
