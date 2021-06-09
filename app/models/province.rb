# frozen_string_literal: true

class Province < ApplicationRecord
  validates :name, presence: true

  validates :gst, :pst, :hst, numericality: { only_decimal: true }
end
