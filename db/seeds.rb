School.create!(name: "Super Users",
               gravatar:  true)
School.create!(name: "Example College")
School.create!(name: "Test College")

User.create!(name:  "Alex Macpherson",
             email: "alexjamesmacpherson@gmail.com",
             password:              "password",
             password_confirmation: "password",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now,
             school_id: 1,
             gravatar:  true)

User.create!(name:  "Alex Macpherson",
             email: "alex@example.com",
             password:              "password",
             password_confirmation: "password",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now,
             school_id: 2,
             color:    rand(1...6)) # Random colors assigned at account creation

User.create!(name:  "Alex Macpherson",
             email: "alex@test.com",
             password:              "password",
             password_confirmation: "password",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now,
             school_id: 3,
             color:    rand(1...6))

49.times do |n|
  name =      Faker::Name.name
  email =     "example-#{n+1}@example.com"
  password =  "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               school_id: 2,
               color:    rand(1...6))
end

74.times do |n|
  name =      Faker::Name.name
  email =     "example-#{n+1}@test.com"
  password =  "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               school_id: 3,
               color:    rand(1...6))
end
