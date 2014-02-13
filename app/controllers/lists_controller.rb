class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def management
    if user_signed_in?
      @lists = current_user.lists.includes(:listeds, :campsites)
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
    @list = List.new(list_params)
    if params[:campsite_id]
      @listed = Listed.new()
      @listed.list_id = @list
      @listed.user_id = current_user
      @listed.save
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
      format.html { redirect_to lists_url }
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
      params.require(:list).permit(:name, :user_id)
    end
end
