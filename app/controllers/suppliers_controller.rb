class SuppliersController < ApplicationController

  def index
    suppliers = Supplier.all.order(id: :asc)
    render json: suppliers.as_json
  end

end
