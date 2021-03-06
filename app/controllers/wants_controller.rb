class WantsController < ApplicationController
  before_action :set_want, only: [:show, :edit, :update, :destroy]
  before_action :verify_user, only: [:destroy, :update]

  # GET /wants
  # GET /wants.json
  def index
    if user_signed_in?
      @wants = current_user.wants
      render layout: "layouts/twoColumn"
    else
      redirect_to new_user_session_path
    end
  end

  # GET /wants/1
  # GET /wants/1.json
  def show
  end

  # GET /wants/new
  def new
    @want = Want.new
  end

  # GET /wants/1/edit
  def edit
  end

  # POST /wants
  # POST /wants.json
  def create
    campsite = Campsite.find(params[:campsite_id])
    if campsite.wants.where(user_id:current_user.id).blank?
      @want = campsite.wants.create(user_id:current_user.id)
    else
      @want = campsite.want.find_by_user_id(current_user.id).first
    end

    respond_to do |format|
      if @want.save
        format.html { redirect_to @want, notice: 'Want was successfully created.' }
        format.json { render action: 'show', status: :created, location: @want }
      else
        format.html { render action: 'new' }
        format.json { render json: @want.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wants/1
  # PATCH/PUT /wants/1.json
  def update
    respond_to do |format|
      if @want.update(want_params)
        format.html { redirect_to @want, notice: 'Want was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @want.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wants/1
  # DELETE /wants/1.json
  def destroy
    @want.destroy
    respond_to do |format|
      format.html { redirect_to wants_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_want
      @want = Want.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def want_params
      params.permit(:want, :wantable_id, :wantable_type)
    end

    def verify_user
      redirect_to forbidden_path unless user_signed_in? && @want.user.id == current_user.id
    end
end
