class OrdersController < ApplicationController
  before_action :require_user

  def index
    @orders = current_user.orders.paginate(page: params[:page], per_page: 2)
  end
end
