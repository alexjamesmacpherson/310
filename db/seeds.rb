School.create!(name: "Super Users")
School.create!(name: "Example College")
School.create!(name: "Test College")

User.create!(name:  "Alex Macpherson",
             email: "alexjamesmacpherson@gmail.com",
             password:              "password",
             password_confirmation: "password",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now,
             school_id: 1)

User.create!(name:  "Alex Macpherson",
             email: "alex@example.com",
             password:              "password",
             password_confirmation: "password",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now,
             school_id: 2)

User.create!(name:  "Alex Macpherson",
             email: "alex@test.com",
             password:              "password",
             password_confirmation: "password",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now,
             school_id: 3)

9.times do |n|
  name =      Faker::Name.name
  email =     "example-#{n+1}@test.com"
  password =  "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               school_id: 2)
end

10.times do |n|
  name =      Faker::Name.name
  email =     "example-#{n+10}@test.com"
  password =  "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               school_id: 3)
end
