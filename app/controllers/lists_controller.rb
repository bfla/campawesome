class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :verify_user, only: [:destroy, :update]

  def management
    if user_signed_in?
      @lists = current_user.lists.includes( listeds: [:listable] )
      render layout: 'layouts/twoColumn'
    else
      respond_to do |format|
        format.html { redirect_to new_registration_path(:user), notice: 'You must have an account to manage lists' }
        format.json { head :no_content }
      end
    end
  end

  # GET /lists
  # GET /lists.json
  def index
    @lists = List.all
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    if user_signed_in?
      @list = List.includes( listeds: [:listable] ).find(params[:id])
      render layout: 'layouts/twoColumn'
    else
      respond_to do |format|
        format.html { redirect_to management_lists_path(:user), notice: 'You must have an account to manage lists' }
        format.json { head :no_content }
      end
    end
  end

  # GET /lists/new
  def new
    @list = List.new
    render layout: 'layouts/twoColumn'
  end

  # GET /lists/1/edit
  def edit
    render layout: 'layouts/twoColumn'
  end

  # POST /lists
  # POST /lists.json
  def create
    #@list = List.new(list_params)
    @list = current_user.lists.create(list_params)
    if params[:campsite_id] && @list.listeds.find_by_campsite_id(params[:campsite_id]).blank?
      campsite = Campsite.find(params[:campsite_id])
      @listed = campsite.listeds.create(list:@list.id, user_id:current_user.id)
      #@listed = Listed.new()
      #@listed.list_id = @list.id
      #@listed.user_id = current_user.id
      #@listed.save
    end

    respond_to do |format|
      if @list.save
        format.html { redirect_to management_lists_path, notice: 'List was successfully created.' }
        format.json { render action: 'show', status: :created, location: @list }
      else
        format.html { render action: 'new' }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to management_lists_path, notice: 'List was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to management_lists_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:name, :campsite_id)
    end

    def verify_user
      redirect_to forbidden_path unless user_signed_in? && @list.user_id == current_user.id
    end
end
