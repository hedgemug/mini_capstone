class ProductsController < ApplicationController

  before_action :authenticate_admin, except: [:index, :show]

  def index
    products = Product.all.order(id: :asc)

    search_term = params[:search]
    if search_term
      products = products.where("name LIKE ?", "%#{search_term}%")
    end

    price_sort = params[:price_sort]
    if price_sort
      products = Product.all.order(price: :asc)
    end

    render json: products.as_json
  end

  def create
    product = Product.new(
      name: params[:name],
      description: params[:description],
      price: params[:price],
      image_url: params[:image_url],
      supplier_id: params[:supplier_id]
    )
    if product.save
      render json: product.as_json
    else
      render json: {errors: product.errors.full_messages, status: :unprocessable_entity}
    end
  else
    render json: {message: "Unauthorized action"}, status: :unauthorized
  end

  def show
    product = Product.find(params[:id])
    render json: product.as_json
  end

  def update
    product = Product.find(params[:id])
    
    product.name = params[:name] || product.name
    product.description = params[:description] || product.description
    product.price = params[:price] || product.price
    product.image_url = params[:image_url] || product.image_url
    product.save

    render json: product.as_json
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    render json: {message: "Successfully destroyed product ##{product.id}"}
  end
end
