User.create!(name:  "Alex Macpherson",
             email: "alex@test.com",
             password:              "password",
             password_confirmation: "password",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name =      Faker::Name.name
  email =     "example-#{n+1}@test.com"
  password =  "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
