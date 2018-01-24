class Product < ApplicationRecord

  validates :name, presence: true

  def is_discounted?
    price.to_f <= 2
  end

  def tax
    price.to_f * 0.09
  end

  def total
    price.to_f + tax
  end

  def as_json
    {
      id: id,
      name: name,
      image_url: image_url,
      price: price,
      description: description,
      tax: tax,
      total: total,
      is_discounted: is_discounted?
    }
  end

end
