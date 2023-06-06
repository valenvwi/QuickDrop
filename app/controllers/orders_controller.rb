class OrdersController < ApplicationController
  before_action :set_order, only: %i[edit update]
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    respond_to do |format|
      if @order.save
        format.html { redirect_to edit_order_path(@order), notice: "Flat was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def updated
    if @order.update(order_params)
      # redirect_to @order
    else
      render :edit
    end
  end


  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:item_description, :item_size, :status, :pickup_name, :pickup_address, :pickup_contact_phone, :pickup_additional_detail, :pickup_at, :dropoff_name, :dropoff_address, :dropoff_contact_phone, :dropoff_additional_detail, :dropoff_at, :price, :distance )
  end

end
