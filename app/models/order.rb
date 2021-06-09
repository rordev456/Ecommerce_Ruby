# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  # before_save :set_subtotal

  # validates :freight, :province, :address, :postal_code, :tax_rate, presence: true

  def subtotal
    order_details.collect { |order_item| order_item.valid? ? order_tem.unit_price * order_item.quantity : 0 }.sum
  end

  private

  def set_subtotal
    self[:subtotal] = subtotal
  end
end
