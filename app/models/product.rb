class Product < ApplicationRecord

  has_many :category_products
  has_many :categories, through: :category_products
  belongs_to :supplier
  has_many :carted_products
  has_many :orders, through: :carted_products

  validates :name, presence: true, uniqueness: true, length: {minimum: 2}
  validates :price, presence: true
  validates :description, length: {in: 10..500}

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
      is_discounted: is_discounted?,
      supplier: supplier.as_json,
      categories: categories.map { |category| category.title }    
    }
  end

end
