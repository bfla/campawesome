class ActivityTypesController < ApplicationController
  before_action :set_activity_type, only: [:show, :edit, :update, :destroy]
  before_action :admin_only

  # GET /activity_types
  # GET /activity_types.json
  def index
    @activity_types = ActivityType.all
  end

  # GET /activity_types/1
  # GET /activity_types/1.json
  def show
  end

  # GET /activity_types/new
  def new
    @activity_type = ActivityType.new
  end

  # GET /activity_types/1/edit
  def edit
  end

  # POST /activity_types
  # POST /activity_types.json
  def create
    @activity_type = ActivityType.new(activity_type_params)

    respond_to do |format|
      if @activity_type.save
        format.html { redirect_to @activity_type, notice: 'Activity type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @activity_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @activity_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activity_types/1
  # PATCH/PUT /activity_types/1.json
  def update
    respond_to do |format|
      if @activity_type.update(activity_type_params)
        format.html { redirect_to @activity_type, notice: 'Activity type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @activity_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activity_types/1
  # DELETE /activity_types/1.json
  def destroy
    @activity_type.destroy
    respond_to do |format|
      format.html { redirect_to activity_types_url }
      format.json { head :no_content }
    end
  end

  private
    def admin_only
      redirect_to forbidden_path unless current_user && current_user.is_admin
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_type
      @activity_type = ActivityType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_type_params
      params.require(:activity_type).permit(:name)
    end
end
