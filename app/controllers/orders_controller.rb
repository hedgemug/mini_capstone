class OrdersController < ApplicationController

  def index
    if current_user
      orders = current_user.orders
      render json: orders.as_json
    else
      render json: {message: "You must be logged in to see orders!"}
    end
  end

  def create
    # user will pass product id and quantity
    product = Product.find_by(id: params[:product_id])
    calculated_subtotal = product.price * params[:quantity].to_i
    calculated_tax = calculated_subtotal * 0.09
    calculated_total = calculated_subtotal + calculated_tax

    order = Order.new(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      subtotal: calculated_subtotal,
      tax: calculated_tax,
      total: calculated_total
    )

    if order.save
      render json: order.as_json
    else
      render json: {errors: order.errors.full_messages}, status: 422
    end
  end

end
