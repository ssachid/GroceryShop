class ProductsController < ApplicationController
  def index
    @products = Product.all.paginate(page: params[:page], per_page: 5)
  end

  def sold
    if params[:products_sold].present?
      @start_date = params[:products_sold][:from]
      @end_date = params[:products_sold][:to]
      @option = params[:products_sold][:option]
      if @start_date && @end_date
        orders = Order.created_between(@start_date, @end_date)
        sold_orders_by_option = sold_orders_by_option(orders, @option)
        @sold_products = get_products_for_orders(sold_orders_by_option)
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
    # orders = {timestamp => [o1, o2, o3...], { timestamp: [...]}}
    products = orders.reduce({}) do |result, (key,values)|
      result[key] = values.map(&:products).flatten
      result # { timestamp: [p1,p2,p3,...], timestamp: [p1,p2,..]}
    end
    products_hash = convert_object_to_attributes(products)
    p "*" * 50
    # p products_hash
    combine_quantity_for_duplicate_products(products_hash)
  end

  def convert_object_to_attributes(products)
    products.reduce({}) do |result, (key,values)|
      # result[key] = values.map(&:attributes)
      result[key] = values.map { |p| {"#{p.name}" => "#{p.quantity}"} }
      result
    end
  end

  def combine_quantity_for_duplicate_products(products)
    # {Thu, 08 Mar 2018=>[{"Kane Bechtelar"=>"8.0"}, {"Kane Bechtelar"=>"8.0"},
                        # {"Anastasia Considine"=>"3.0"}, {"Trace Lebsack"=>"7.0"}, ..]}
    products.reduce({}) do |result, (key, products_array)|
      products_array = products_array.inject() do |memo, product|
        memo.merge(product) { |k, old_v, new_v| old_v.to_i + new_v.to_i}
      end
      result[key] = products_array
      result
    end
  end
end
