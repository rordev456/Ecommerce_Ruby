# frozen_string_literal: true

module ApplicationHelper
  def current_order
    if !session[:order_id].nil?
      Order.find[session[:order_id]]
    else
      order = Order.new
      order.id = [:order_id]
      # order.customer_id = current_user.id
      order
    end
  end
end
