School.create!(name: "Super Users",
               gravatar:  true)
School.create!(name: "Example College")
School.create!(name: "Test College")

User.create!(name:  "Alex Macpherson",
             email: "alexjamesmacpherson@gmail.com",
             password:              "password",
             password_confirmation: "password",
             bio:       Faker::Lorem.paragraph(3),
             admin:     true,
             activated: true,
             activated_at: Time.zone.now,
             school_id: 1,
             gravatar:  true)

User.create!(name:  "Alex Macpherson",
             email: "alex@example.com",
             password:              "password",
             password_confirmation: "password",
             bio:       Faker::Lorem.paragraph(3),
             admin:     true,
             activated: true,
             activated_at: Time.zone.now,
             school_id: 2,
             color:    rand(1...6)) # Random colors assigned at account creation

User.create!(name:  "Alex Macpherson",
             email: "alex@test.com",
             password:              "password",
             password_confirmation: "password",
             bio:       Faker::Lorem.paragraph(3),
             admin:     true,
             activated: true,
             activated_at: Time.zone.now,
             school_id: 3,
             color:    rand(1...6))

rand(30...100).times do |n|
  name =      Faker::Name.name
  email =     "example-#{n+1}@example.com"
  password =  "password"
  bio =       Faker::Lorem.paragraph(3)
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               bio:       bio,
               activated: true,
               activated_at: Time.zone.now,
               school_id: 2,
               color:    rand(1...6))
end

rand(30...100).times do |n|
  name =      Faker::Name.name
  email =     "example-#{n+1}@test.com"
  password =  "password"
  bio =       Faker::Lorem.paragraph(3)
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               bio:       bio,
               activated: true,
               activated_at: Time.zone.now,
               school_id: 3,
               color:    rand(1...6))
end
