class Supplier < ApplicationRecord

  has_many :products #returns an array of hashes

  def as_json
    {
      id: id,
      name: name,
      email: email,
      phone_number: phone_number,
      products: products.map { |product| product.name }
    }
  end

end
