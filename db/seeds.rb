50.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  user = User.create!(name: name,
                      email: email,
                      password: password,
                    )



end