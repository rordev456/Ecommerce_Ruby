# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart, only: %i[create destroy]

  def show
    @order_items = current_order.order_details
  end

  def create
    @cart.add_product(params)

    if @cart.save
      redirect_to cart_path
    else
      flash[:error] = 'There was a problem saving.'
      redirect_to @product
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_path
  end

  private

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end
