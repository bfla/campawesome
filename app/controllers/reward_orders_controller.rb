class RewardOrdersController < ApplicationController
  before_action :set_reward_order, only: [:show, :edit, :update, :destroy]
  before_action :admin_only, only: [:index, :edit, :update, :destroy]

  # GET /reward_orders
  # GET /reward_orders.json
  def index
    @reward_orders = RewardOrder.all
  end

  # GET /reward_orders/1
  # GET /reward_orders/1.json
  def show
    render layout:"layouts/twoColumn"
  end

  # GET /reward_orders/new
  def new
    @reward_order = RewardOrder.new
  end

  # GET /reward_orders/1/edit
  def edit
  end

  # POST /reward_orders
  # POST /reward_orders.json
  def create
    @reward_order = RewardOrder.new(reward_order_params)

    respond_to do |format|
      if @reward_order.save
        format.html { redirect_to @reward_order, notice: 'Reward order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @reward_order }
      else
        format.html { render action: 'new' }
        format.json { render json: @reward_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reward_orders/1
  # PATCH/PUT /reward_orders/1.json
  def update
    respond_to do |format|
      if @reward_order.update(reward_order_params)
        format.html { redirect_to @reward_order, notice: 'Reward order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reward_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reward_orders/1
  # DELETE /reward_orders/1.json
  def destroy
    @reward_order.destroy
    respond_to do |format|
      format.html { redirect_to reward_orders_url }
      format.json { head :no_content }
    end
  end

  private
    def admin_only
      redirect_to forbidden_path unless current_user && current_user.is_admin
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_reward_order
      @reward_order = RewardOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reward_order_params
      params.permit(:reward_order, :product_id, :user_id)
    end
end
