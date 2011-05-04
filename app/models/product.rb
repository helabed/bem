class Product < ActiveRecord::Base
  belongs_to :category

  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :image_url, :format => {
            :with  => %r{\.(gif|jpg|png)$}i,
            :message => 'must be a URL for GIF, JPG or PNG image.' }
end

# == Schema Information
# Schema version: 20110418172341
#
# Table name: products
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  description :text
#  image_url   :string(255)
#  price       :decimal(8, 2)
#  created_at  :datetime
#  updated_at  :datetime
#  category_id :integer(4)
#

