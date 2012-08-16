# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.first_name            "hani"
  user.last_name             "mani"
  user.email                 "hani@mani.com"
  user.address               "11 rue eddison"
  user.phone                 "011-333-4444"
  user.city                  "Beirut"
  user.country               "Lebanon"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo bar"
  micropost.association :user
end

Factory.define :order do |order|
  order.name                  "order: 1 for hani mani"
  order.email                 "hani@mani.com"
  order.address               "101 main st"
  order.pay_type              "Cash on Delivery (COD)"
end
