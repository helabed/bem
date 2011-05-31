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

    mankoushe = Product.create(:title => 'Mankoushe',
      :description =>
        %{Mankoushe be zatar},
      :image_url => '/images/mankoushe.jpg',
      :price => 950)

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

    croissant_plain = Product.create(:title => 'Croissant - plain',
      :description =>
        %{tasty plain croissant backed in our specialty ovens},
      :image_url => '/images/croissant_plain.jpg',
      :price => 750)

    croissant_chocolate = Product.create(:title => 'Croissant - chocolate',
      :description =>
        %{tasty chocolate croissant backed in our specialty ovens},
      :image_url => '/images/croissant_chocolate.jpg',
      :price => 950)

    tide = Product.create(:title => 'Tide with bleach',
      :description =>
        %{large container of the number 1 detergent with bleach},
      :image_url => '/images/tide.jpg',
      :price => 18950)

    lemon_shampoo = Product.create(:title => 'Tisserand Lemon shampoo',
      :description =>
        %{Tisserand all natural organic Lemon shampoo},
      :image_url => '/images/lemon_shampoo.png',
      :price => 9950)

    helloum_cheese = Product.create(:title => 'Helloum Cheese - local',
      :description =>
        %{Teanail Helloum Cheese},
      :image_url => '/images/helloum_cheese.jpg',
      :price => 2950)

    labaneh = Product.create(:title => 'Labaneh - local',
      :description =>
        %{Teanail Labaneh - 1 kg.},
      :image_url => '/images/labneh.jpg',
      :price => 2950)

    lean_cuisine_pasta_chicken = Product.create(:title => 'Pasta chicken',
      :description =>
        %{Lean Cuisine Bowe tie pasta chciken},
      :image_url => '/images/lean_cuisine_pasta_chicken.jpg',
      :price => 3950)

    cucumber = Product.create(:title => 'Cucumbers',
      :description =>
        %{Fresh cucumber - 1 kg.},
      :image_url => '/images/cucumbers.jpg',
      :price => 950)

    tomato = Product.create(:title => 'Tomatoes',
      :description =>
        %{Fresh tomato - 1 kg.},
      :image_url => '/images/tomatoes.jpg',
      :price => 1550)

    green_bean = Product.create(:title => 'Green Beans',
      :description =>
        %{Fresh green beans - 1 kg.},
      :image_url => '/images/green_beans.jpg',
      :price => 1250)

    coke = Product.create(:title => 'Coca Cola Classic',
      :description =>
        %{Coca Cola Classic - 1 can},
      :image_url => '/images/coke.jpg',
      :price => 1250)

    seven_up = Product.create(:title => '7 Up',
      :description =>
        %{7 Up lemon drink - 1 can},
      :image_url => '/images/seven_up.jpg',
      :price => 1250)

    baklava = Product.create(:title => 'Baklava',
      :description =>
        %{Delicious baklava ready to eat - 1 kg.},
      :image_url => '/images/baklava.jpg',
      :price => 8250)

    marlboro = Product.create(:title => 'Marlboro Cigarettes',
      :description =>
        %{Malboro cigarettes - 1 pack},
      :image_url => '/images/marlboro.jpg',
      :price => 5550)

    rothmans = Product.create(:title => 'Rothmans Cigarettes',
      :description =>
        %{Rothmans cigarettes - 1 pack},
      :image_url => '/images/rothmans.gif',
      :price => 5950)

    kent = Product.create(:title => 'Kent Cigarettes',
      :description =>
        %{Kent cigarettes - 1 pack},
      :image_url => '/images/kent.gif',
      :price => 7250)

    lucky_strike = Product.create(:title => 'Lucky Strike Cigarettes',
      :description =>
        %{Lucky Strike cigarettes - 1 pack},
      :image_url => '/images/lucky_strike.gif',
      :price => 3250)

    ################# Categories table #################
    breads_and_croissants = Category.create(:name => 'Breads and Croissants')
      breads = breads_and_croissants.children.create(:name => 'Breads')
        breads.products << mankoushe
        white_bread = breads.children.create(:name => 'White Bread')
          white_bread.products << pita
          white_bread.products << brownberry_white
        dark_bread = breads.children.create(:name => 'Dark Bread')
          dark_bread.products << brownberry_wheat
      croissants = breads_and_croissants.children.create(:name => 'Croissants')
        croissants.products << croissant_plain
        croissants.products << croissant_chocolate

    detergents = Category.create(:name => 'Detergents')
      detergents.products << tide
    personal_hygiene = Category.create(:name => 'Personal Hygiene')
      personal_hygiene.products << lemon_shampoo
    groceries_and_canned_food = Category.create(:name => 'Groceries and Canned Foods')
      groceries_and_canned_food.products << foule
    milk_and_cheese = Category.create(:name => 'Milk and Cheese')
      milk_and_cheese.products << helloum_cheese
      milk_and_cheese.products << labaneh
    frozen_foods = Category.create(:name => 'Frozen Foods')
      frozen_foods.products << lean_cuisine_pasta_chicken
    fruits = Category.create(:name => 'Fruits')
      fruits.products << apples
      fruits.products << oranges
    vegetables = Category.create(:name => 'Vegetables')
      vegetables.products << cucumber
      vegetables.products << tomato
      vegetables.products << green_bean
    drinks = Category.create(:name => 'Drinks')
      drinks.products << coke
      drinks.products << seven_up
    sweets_and_snacks = Category.create(:name => 'Sweets and Snacks')
      sweets_and_snacks.products << baklava
    cigarettes_and_tobaccos = Category.create(:name => 'Cigarettes and Tobaccos')
      cigarettes_and_tobaccos.products << marlboro << lucky_strike << kent << rothmans

  end
end

include SeedDatabase
seed_db
