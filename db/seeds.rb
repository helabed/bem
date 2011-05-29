# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

module SeedDatabase
  def seed_db
    LineItem.delete_all
    Cart.delete_all
    Order.delete_all
    Product.delete_all
    Category.delete_all

    apples = Product.create(:title => 'Apples - misc.',
      :description =>
        %{Very tasty apples from Faraya},
      :image_url =>   '/images/apples.jpg',
      :price => 1230)

    oranges = Product.create(:title => 'Oranges - valencia',
      :description =>
        %{Delicious spanish oranges from Valencia},
      :image_url => '/images/oranges.jpg',
      :price => 1355)

    pita = Product.create(:title => 'Pita bread',
      :description =>
        %{6 loafs of small white pita bread or Arabic bread},
      :image_url => '/images/pita_bread.jpg',
      :price => 750)

    brownberry_wheat = Product.create(:title => 'Brownberry wheat bread',
      :description =>
        %{one kilogram of wheat toast bread},
      :image_url => '/images/brownberry_wheat_bread.jpg',
      :price => 9000)

    brownberry_white = Product.create(:title => 'Brownberry white bread',
      :description =>
        %{one kilogram of white whole grain bread},
      :image_url => '/images/brownberry_whole_grain_white_bread.jpg',
      :price => 7699)

    foule = Product.create(:title => 'Foule mudammas (Fava beans)',
      :description =>
        %{tasty cooked fava beans},
      :image_url => '/images/foule_mudammas.jpg',
      :price => 899)


    ################# Categories table #################
    breads_and_croissants = Category.create(:name => 'Breads and Croissants')
      breads = breads_and_croissants.children.create(:name => 'Breads')
        white_bread = breads.children.create(:name => 'White Bread')
          white_bread.products << pita
          white_bread.products << brownberry_white
        dark_bread = breads.children.create(:name => 'Dark Bread')
          dark_bread.products << brownberry_wheat
      breads_and_croissants.children.create(:name => 'Croissants')

    detergents = Category.create(:name => 'Detergents')
    personal_hygiene = Category.create(:name => 'Personal Hygiene')
    groceries_and_canned_food = Category.create(:name => 'Groceries and Canned Foods')
      groceries_and_canned_food.products << foule
    milk_and_cheese = Category.create(:name => 'Milk and Cheese')
    frozen_foods = Category.create(:name => 'Frozen Foods')
    fruits = Category.create(:name => 'Fruits')
      fruits.products << apples
      fruits.products << oranges
    vegetables = Category.create(:name => 'Vegetables')
    drinks = Category.create(:name => 'Drinks')
    sweets_and_snacks = Category.create(:name => 'Sweets and Snacks')
    cigarettes_and_tobaccos = Category.create(:name => 'Cigarettes and Tobaccos')

  end
end

include SeedDatabase
seed_db
