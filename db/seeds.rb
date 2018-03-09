# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user1 = User.find_by(username: "ssachid")
user2 = User.find_by(username: "jack")

5.times do
  Product.create(name: Faker::Name.name, quantity: rand(1..10), price: rand(0.1..10.0).round(2), image: Faker::Avatar.image, description: Faker::Lorem.sentence )
end


5.times do
  o = Order.create(user_id: [user1, user2].sample.id)
  3.times do
    o.products << Product.find(rand(1..5))
  end
end
