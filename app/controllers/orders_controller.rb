class OrdersController < ApplicationController
  before_action :set_order, only: %i[show specialshow edit update]
  def new
    @order = Order.new
  end

  def show
  end

  def specialshow
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    respond_to do |format|
      if @order.save
        format.html { redirect_to edit_order_path(@order) }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to order_path(@order)
    else
      render :edit
    end
  end

  def accept
    @order = Order.find(params[:order_id])
    @order.update(status: "Accepted")
    redirect_to order_path(@order)
    # redirect_to orders_path, notice: "order accepted!"
  end

  def markascompleted
    @order = Order.find(params[:order_id])
    @order.update(status: "Completed")
    redirect_to order_path(@order)
    # redirect_to orders_path, notice: "order completedd!"
  end

  def cancel
    @order = Order.find(params[:order_id])
    @order.update(status: "Cancaled")
    redirect_to order_path(@order)
    # redirect_to orders_path, notice: "order canceled!"
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:item_description, :item_size, :status, :pickup_name, :pickup_address, :pickup_contact_phone, :pickup_additional_detail, :pickup_at, :dropoff_name, :dropoff_address, :dropoff_contact_phone, :dropoff_additional_detail, :dropoff_at, :price, :distance )
  end


end
