# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

module SeedDatabase
  def load_image_to_product_table the_product, the_image
    path_to_file = File.dirname(__FILE__) + "/../public/images/#{the_image}"
    the_product.image = File.open(path_to_file)
    the_product.save!
  end

  def seed_db
    LineItem.delete_all
    Cart.delete_all
    Order.delete_all
    Product.delete_all
    Category.delete_all

    apples = Product.create(:title => 'Apples - misc.',
      :description =>
        %{Very tasty apples from Faraya},
      :price => 1230)
    load_image_to_product_table apples, 'apples.jpg'

    oranges = Product.create(:title => 'Oranges - valencia',
      :description =>
        %{Delicious spanish oranges from Valencia},
      :price => 1355)
    load_image_to_product_table oranges, 'oranges.jpg'

    pita = Product.create(:title => 'Pita bread',
      :description =>
        %{6 loafs of small white pita bread or Arabic bread},
      :price => 750)
    load_image_to_product_table pita, 'pita_bread.jpg'

    mankoushe = Product.create(:title => 'Mankoushe',
      :description =>
        %{Mankoushe be zatar},
      :price => 950)
    load_image_to_product_table mankoushe, 'mankoushe.jpg'

    brownberry_wheat = Product.create(:title => 'Brownberry wheat bread',
      :description =>
        %{one kilogram of wheat toast bread},
      :price => 9000)
    load_image_to_product_table brownberry_wheat, 'brownberry_wheat_bread.jpg'

    brownberry_white = Product.create(:title => 'Brownberry white bread',
      :description =>
        %{one kilogram of white whole grain bread},
      :price => 7699)
    load_image_to_product_table brownberry_white, 'brownberry_whole_grain_white_bread.jpg'

    foule = Product.create(:title => 'Foule mudammas (Fava beans)',
      :description =>
        %{tasty cooked fava beans},
      :price => 899)
    load_image_to_product_table foule, 'foule_mudammas.jpg'

    croissant_plain = Product.create(:title => 'Croissant - plain',
      :description =>
        %{tasty plain croissant backed in our specialty ovens},
      :price => 750)
    load_image_to_product_table croissant_plain, 'croissant_plain.jpg'

    croissant_chocolate = Product.create(:title => 'Croissant - chocolate',
      :description =>
        %{tasty chocolate croissant backed in our specialty ovens},
      :price => 950)
    load_image_to_product_table croissant_chocolate, 'croissant_chocolate.jpg'

    tide = Product.create(:title => 'Tide with bleach',
      :description =>
        %{large container of the number 1 detergent with bleach},
      :price => 18950)
    load_image_to_product_table tide, 'tide.jpg'

    lemon_shampoo = Product.create(:title => 'Tisserand Lemon shampoo',
      :description =>
        %{Tisserand all natural organic Lemon shampoo},
      :price => 9950)
    load_image_to_product_table lemon_shampoo, 'lemon_shampoo.png'

    helloum_cheese = Product.create(:title => 'Helloum Cheese - local',
      :description =>
        %{Teanail Helloum Cheese},
      :price => 2950)
    load_image_to_product_table helloum_cheese, 'helloum_cheese.jpg'

    labaneh = Product.create(:title => 'Labaneh - local',
      :description =>
        %{Teanail Labaneh - 1 kg.},
      :price => 2950)
    load_image_to_product_table labaneh, 'labneh.jpg'

    lean_cuisine_pasta_chicken = Product.create(:title => 'Pasta chicken',
      :description =>
        %{Lean Cuisine Bowe tie pasta chciken},
      :price => 3950)
    load_image_to_product_table lean_cuisine_pasta_chicken, 'lean_cuisine_pasta_chicken.jpg'

    cucumber = Product.create(:title => 'Cucumbers',
      :description =>
        %{Fresh cucumber - 1 kg.},
      :price => 950)
    load_image_to_product_table cucumber, 'cucumbers.jpg'

    tomato = Product.create(:title => 'Tomatoes',
      :description =>
        %{Fresh tomato - 1 kg.},
      :price => 1550)
    load_image_to_product_table tomato, 'tomatoes.jpg'

    green_bean = Product.create(:title => 'Green Beans',
      :description =>
        %{Fresh green beans - 1 kg.},
      :price => 1250)
    load_image_to_product_table green_bean, 'green_beans.jpg'

    coke = Product.create(:title => 'Coca Cola Classic',
      :description =>
        %{Coca Cola Classic - 1 can},
      :price => 1250)
    load_image_to_product_table coke, 'coke.jpg'

    seven_up = Product.create(:title => '7 Up',
      :description =>
        %{7 Up lemon drink - 1 can},
      :price => 1250)
    load_image_to_product_table seven_up, 'seven_up.jpg'

    baklava = Product.create(:title => 'Baklava',
      :description =>
        %{Delicious baklava ready to eat - 1 kg.},
      :price => 8250)
    load_image_to_product_table baklava, 'baklava.jpg'

    marlboro = Product.create(:title => 'Marlboro Cigarettes',
      :description =>
        %{Malboro cigarettes - 1 pack},
      :price => 5550)
    load_image_to_product_table marlboro, 'marlboro.jpg'

    rothmans = Product.create(:title => 'Rothmans Cigarettes',
      :description =>
        %{Rothmans cigarettes - 1 pack},
      :price => 5950)
    load_image_to_product_table rothmans, 'rothmans.gif'

    kent = Product.create(:title => 'Kent Cigarettes',
      :description =>
        %{Kent cigarettes - 1 pack},
      :price => 7250)
    load_image_to_product_table kent, 'kent.gif'

    lucky_strike = Product.create(:title => 'Lucky Strike Cigarettes',
      :description =>
        %{Lucky Strike cigarettes - 1 pack},
      :price => 3250)
    load_image_to_product_table lucky_strike, 'lucky_strike.gif'

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
