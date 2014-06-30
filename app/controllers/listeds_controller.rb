class ListedsController < ApplicationController
  before_action :set_listed, only: [:show, :edit, :update, :destroy]
  before_action :verify_user, only: [:destroy, :update]

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
    if user_signed_in? && current_user.lists.find(params[:list_id]).present? #verify ownership
      unless campsite.listeds.present? && campsite.listeds.where(list_id:params[:list_id]).present?
        #Listed.find_by(list_id:params[:list_id], listable_id:campsite.id, listable_type:'Campsite').blank?
        # if it passes these hurdles, create the list
        #if campsite.listeds.find_by(list_id:params[:list_id]).blank? && !current_user.lists.find_by(list_id:params[:list_id]).blank?
        @listed = campsite.listeds.create(list_id:params[:list_id])
      else
        @listed = campsite.listeds.find_by(list_id:params[:list_id])
      end
    end

    respond_to do |format|
      if @listed.save
        puts "Campsite was added to list"
        format.html { redirect_to session[:previous_url], notice: 'Listed was successfully created.' }
        format.json { render json: {message:"Created successfully"} }
      else
        puts "Campsite was not added to list"
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

  def ajax_destroy
    @list = List.find(params[:list_id])
    puts "Got list (to remove the listed from)..."
    if user_signed_in? && @list.user == current_user #verify ownership
      puts "Verified ownership of listed..."
      
      @campsite = Campsite.includes(:listeds).find(params[:campsite_id])
      @listed = @campsite.listeds.where(list_id:params[:list_id]).first
      if @listed.present?
        puts "Found list item object..."
        @listed.destroy
        puts "Destroyed list item..."

        respond_to do |format|
          puts "Sending JSON response..."
          format.json { render json: {message:"Campsite was removed from list"} }
        end
      else
        puts "Could not find list item object to destroy..."
        respond_to do |format|
          puts "Sending JSON response..."
          format.json { render json: {message:"Campsite not removed"} }
        end
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

    def verify_user
      redirect_to forbidden_path unless user_signed_in? && @listed.list.user_id == current_user.id
    end
end
