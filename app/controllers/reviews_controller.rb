class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    #@reviews = Review.all
    if user_signed_in?
      @reviews = current_user.reviews
      render layout:"layouts/twoColumn"
    else
      redirect_to new_user_session_path
    end
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @campsite = Campsite.find(params[:campsite_id])
    if @campsite.reviews.find_by(user_id:current_user.id).blank?
      @review = @campsite.reviews.create(body: params[:body], user_id:current_user.id)
      @review.save
    end
    if params[:rating].to_f != 0.0 && @campsite.ratings.find_by(user_id:current_user.id).blank?
      @rating = @campsite.ratings.create(value: params[:rating].to_f, user_id:current_user.id, review_id:@review.id)
      @rating.save
      @campsite.resave_avg_rating
      @campsite.save
    end
    respond_to do |format|
      if @review && @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render action: 'show', status: :created, location: @review }
      else
        format.html { render action: 'new' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.permit(:review, :body, :reviewable_id, :reviewable_type)
    end
end
