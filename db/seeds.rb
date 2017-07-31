# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first


User.destroy_all
puts 'Loading Users...'
u1 = User.create email: 'alice@gmail.com' , name: 'Alice Tang' , password: 'chicken', is_admin:true
u2 = User.create email: 'dummy@gmail.com' , name: 'Tom Brady' , password: 'chicken', is_admin:false
