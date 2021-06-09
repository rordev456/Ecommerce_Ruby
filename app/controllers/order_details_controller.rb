# frozen_string_literal: true

class OrderDetailsController < ApplicationController
  before_action :authenticate_user!

  def create
    @order = current_order
    logger.debug "New order: #{@order.attributes.inspect}"
    @order_detail = @order.order_details.new(order_params)
    @order.save
    logger.debug "New order: #{@order.attributes.inspect}"

    session[:order_id] = @order.id

    redirect_to :root
  end

  def update
    @order = current_order
    @order_item = @order.order_details.find(params[:id])
    @order_item.update_attributes(order_params)
    @order_items = current_order.order_items
end

  def destroy
    @order = current_order
    @order_item = @order.order_details.find(params[:id])
    @order_item.destroy
    @order_items = current_order.order_items
  end

  private

  def order_params
    params.require(:order_detail).permit(:product_id, :quantity)
  end
end
