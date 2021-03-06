class Product < ActiveRecord::Base
  # product describes an item sold
  belongs_to :category
  has_many :line_items

  mount_uploader :image, ImageUploader

  default_scope :order => 'title'

  validates :title, :description, :price, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :image_url, :format => {
              :with  => %r{\.(gif|jpg|png)$}i,
              :message => 'must be a URL for GIF, JPG or PNG image.',
              :allow_blank => true}

  before_destroy :ensure_not_referenced_by_any_line_item

  private

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end


# == Schema Information
# Schema version: 20110607030531
#
# Table name: products
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  description :text
#  price       :decimal(8, 2)
#  created_at  :datetime
#  updated_at  :datetime
#  category_id :integer(4)
#  image       :string(255)
#

