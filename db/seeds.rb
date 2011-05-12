# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Product.delete_all
Cart.delete_all

Product.create(:title => 'Apples - misc.',
  :description =>
    %{Very tasty apples from Faraya},
  :image_url =>   '/images/apples.jpg',
  :price => 1230)

Product.create(:title => 'Oranges - valencia',
  :description =>
    %{Delicious spanish oranges from Valencia},
  :image_url => '/images/oranges.jpg',
  :price => 1355)

Product.create(:title => 'Pita bread',
  :description =>
    %{6 loafs of small white pita bread or Arabic bread},
  :image_url => '/images/pita_bread.jpg',
  :price => 750)

Product.create(:title => 'Brownberry wheat bread',
  :description =>
    %{one kilogram of wheat toast bread},
  :image_url => '/images/brownberry_wheat_bread.jpg',
  :price => 9000)

Product.create(:title => 'Brownberry white bread',
  :description =>
    %{one kilogram of white whole grain bread},
  :image_url => '/images/brownberry_whole_grain_white_bread.jpg',
  :price => 7699)

Product.create(:title => 'Foule mudammas (Fava beans)',
  :description =>
    %{tasty cooked fava beans},
  :image_url => '/images/foule_mudammas.jpg',
  :price => 899)
