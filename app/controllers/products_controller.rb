# frozen_string_literal: true

class ProductsController < ApplicationController
  add_flash_types :info # ,:error, :warning
  before_action :initialize_session
  before_action :load_cart

  @cart_id ||= 0

  def index
    @products = if params[:option] == 'New'
                  Product.order('created_at DESC, category_id')
                elsif params[:option] == 'Updated'
                  Product.order('updated_at DESC, category_id')
                else
                  Product.all
                end

    @search_results = @products.paginate(page: params[:page], per_page: 5)

    #  This is from the rails application cart tutorial
    @order_detail = current_order.order_details.new
  end

  def show
    @product = Product.find(params[:id])
  end

  def search_results
    flash[:notice] = ''
    @products = nil
    if params[:product][:category_id].present? && params[:query].present?
      @query = params[:query].downcase
      @category = params[:product][:category_id]
      @products = Product.where('category_id=? and lower(product_name) LIKE ? ', @category.to_s, "%#{@query}%")
      flash[:notice] = "no results for #{@query}, #{@category}" if @products.empty?
    elsif params[:product][:category_id].present?
      @category = params[:product][:category_id]
      @products = Product.where('category_id=? ', @category.to_s)
      flash[:notice] = "no results for #{@category}" if @products.empty?
    elsif params[:query].present?
      @query = params[:query]
      @products = Product.where('product_name LIKE ?', "%#{@query}%")
      flash[:notice] = "no results for #{@query}" if @products.empty?
    elsif params[:product][:category_id].to_s.empty? || @products.nil?
      flash[:notice] = 'No products found.'
    end
  end

  # def add_to_cart
  #   id = params[:id].to_i
  #   @query = params[:query].to_i
  #   session[:cart] << { id: id, quantity: @query } unless session[:cart].include?(id)
  #   redirect_to root_path
  # end

  def add_to_cart
    id = params[:id].to_i
    @query = params[:query].to_i
    session[:cart] << { id: id, quantity: @query } unless session[:cart].include?(id)
    @cart_id += 1
    session[:cart_id] = @cart_id
    redirect_to :controller => 'orders', :action => 'create'
  end

  def load_cart
    @cart = Product.find(session[:cart].map { |hash| hash['id'] })
    @quantity = session[:cart].map { |hash| hash['quantity'] }
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete_if { |hash| hash['id'] == id }
    redirect_back(fallback_location: root_path)
  end

  def edit_the_cart
    id = params[:id].to_i
    @query = params[:query].to_i

    session[:cart].delete_if { |hash| hash['id'] == id }
    session[:cart] << { id: id, quantity: @query } unless session[:cart].include?(id)
    redirect_to root_path
  end

  private

  def initialize_session
    session[:cart] ||= []
  end
end
