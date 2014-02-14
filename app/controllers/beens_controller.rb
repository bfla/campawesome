class BeensController < ApplicationController
  before_action :set_been, only: [:show, :edit, :update, :destroy]

  # GET /beens
  # GET /beens.json
  def index
    if user_signed_in?
      @beens = current_user.beens
      render layout: "layouts/twoColumn"
    else
      redirect_to new_user_session_path
    end
  end

  # GET /beens/1
  # GET /beens/1.json
  def show
  end

  # GET /beens/new
  def new
    @been = Been.new
  end

  # GET /beens/1/edit
  def edit
  end

  # POST /beens
  # POST /beens.json
  def create
    campsite = Campsite.find(params[:campsite_id])
    if campsite.beens.where(user_id:@user).blank?
      @been = campsite.beens.create(user_id:params[:user_id])
    else
      @been = campsite.beens.find_by_user_id(current_user).first
    end

    respond_to do |format|
      if @been.save
        format.html { redirect_to @been, notice: 'Been was successfully created.' }
        format.json { render action: 'show', status: :created, location: @been }
      else
        format.html { render action: 'new' }
        format.json { render json: @been.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beens/1
  # PATCH/PUT /beens/1.json
  def update
    respond_to do |format|
      if @been.update(been_params)
        format.html { redirect_to @been, notice: 'Been was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @been.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beens/1
  # DELETE /beens/1.json
  def destroy
    @been.destroy
    respond_to do |format|
      format.html { redirect_to beens_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_been
      @been = Been.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def been_params
      #params.require(:been).permit(:campsite_id, :user_id)
      params.permit(:been, :beenable_id, :user_id, :beenable_type)
    end
end
