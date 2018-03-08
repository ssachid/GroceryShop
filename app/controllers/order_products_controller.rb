class OrderProductsController < ApplicationController
  def index
    order = Order.find_by(id: params[:order])
    @products = order.products
  end
end
