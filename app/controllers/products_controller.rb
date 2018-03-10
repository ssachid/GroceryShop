class ProductsController < ApplicationController
  before_action :require_admin, only: [:sold]

  def index
    @products = Product.all.paginate(page: params[:page], per_page: 5)
  end

  def sold
    if params[:products_sold].present?
      @start_date, @end_date, @option = params[:products_sold][:from],
                                        params[:products_sold][:to],
                                        params[:products_sold][:option]

      if @start_date.present? && @end_date.present? && @option.present?
        # returns all the orders created within a time range
        orders = Order.created_between(@start_date, @end_date)

        if !orders.empty?
          # groups orders by selected option -> day/week/month
          sold_orders_by_option = sold_orders_by_option(orders, @option)
          # returns all the products for orders
          @sold_products = get_products_for_orders(sold_orders_by_option)
        else
          flash[:danger] = "No orders for this time duration"
          redirect_back(fallback_location: root_path)
        end
      else
        flash[:danger] = "Start date, End date or Option invalid"
        redirect_back(fallback_location: root_path)
      end
    end
  end


  private

  def sold_orders_by_option(collection, option)
    if !(collection.empty?) && !option.empty?
      if option == 'Day'
        return collection.group_by_day { |order| order.created_at }
      elsif option == 'Week'
        return collection.group_by_week { |order| order.created_at }
      else
        return collection.group_by_month { |order| order.created_at }
      end
    end
  end

  def get_products_for_orders(orders)
    products = orders.reduce({}) do |result, (key,values)|
      result[key] = values.map(&:products).flatten
      result
    end
    products_hash = convert_object_to_attributes(products)
    combine_quantity_for_duplicate_products(products_hash)
  end

  def convert_object_to_attributes(products)
    products.reduce({}) do |result, (key,values)|
      result[key] = values.map { |p| {"#{p.name}" => "#{p.quantity}"} }
      result
    end
  end

  def combine_quantity_for_duplicate_products(products)
    products.reduce({}) do |result, (key, products_array)|
      products_array = products_array.inject() do |memo, product|
        memo.merge(product) { |k, old_v, new_v| old_v.to_f + new_v.to_f}
      end
      result[key] = products_array
      result
    end
  end

  # checks if the user is an admin
  def require_admin
    if !logged_in? && !current_user.admin?
      flash[:error] = "You must be an admin to perform that action"
      redirect_back(fallback_location: root_path)
    end
  end
end
