# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @orders = Order.all
    @cart = Product.find(session[:cart].map { |hash| hash['id'] })
    @quantity = session[:cart].map { |hash| hash['quantity'] }
  end

  def show
    @orders = Order.all
  end

  def create
    @order = Order.create(
      id: 1,
      province: 'Manitoba',
      tax_rate: 0.12,
      user_id: current_user
    )
  end
end
