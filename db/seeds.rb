# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
30.times do

    user = User.new
    a = SecureRandom.hex
    user.name = Devise.friendly_token[0,10]
    user.email = Devise.friendly_token[0,10] + "@kiet.edu"
    password = Devise.friendly_token[0,20]
    user.password = password
    user.password_confirmation =  password
    user.skip_confirmation!
    user.save


end