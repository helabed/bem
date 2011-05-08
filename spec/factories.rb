# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "hani mani"
  user.email                 "hani@mani.com"
  #user.name                  "Michael Hartl"
  #user.email                 "mhartl@example.com"
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
  order.name                  "hani mani"
  order.email                 "hani@mani.com"
  order.address               "101 main st"
  order.pay_type              "Cash on Delivery (COD)"
end
