class VibesController < ApplicationController
  before_action :set_vibe, only: [:show, :edit, :update, :destroy]

  # GET /vibes
  # GET /vibes.json
  def index
    @vibes = Vibe.all
  end

  # GET /vibes/1
  # GET /vibes/1.json
  def show
  end

  # GET /vibes/new
  def new
    @vibe = Vibe.new
  end

  # GET /vibes/1/edit
  def edit
  end

  # POST /vibes
  # POST /vibes.json
  def create
    @vibe = Vibe.new(vibe_params)

    respond_to do |format|
      if @vibe.save
        format.html { redirect_to @vibe, notice: 'Vibe was successfully created.' }
        format.json { render action: 'show', status: :created, location: @vibe }
      else
        format.html { render action: 'new' }
        format.json { render json: @vibe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vibes/1
  # PATCH/PUT /vibes/1.json
  def update
    respond_to do |format|
      if @vibe.update(vibe_params)
        format.html { redirect_to @vibe, notice: 'Vibe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @vibe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vibes/1
  # DELETE /vibes/1.json
  def destroy
    @vibe.destroy
    respond_to do |format|
      format.html { redirect_to vibes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vibe
      @vibe = Vibe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vibe_params
      params.require(:vibe).permit(:campsite_id, :tribe_id)
    end
end
