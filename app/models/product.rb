# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  price       :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ActiveRecord::Base
  has_many :line_items
  before_destroy :check_if_referenced_by_line_items

  validates :title, :description, presence: true
  validates :price, numericality: {
      greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true

  def self.latest
    Product.order(:updated_at).last
  end

  def check_if_referenced_by_line_items
    if self.line_items.empty?
      true
    else
      errors.add(:base, "Há items relacionados, não pode ser removido!")
      false
    end
  end
end
