User.create! name: "Example User", email: "example@railstutorial.org",
  password: "19041996", password_confirmation: "19041996",
  is_admin: true, activated: true, activated_at: Time.zone.now

Settings.db.slot.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = "password"
  User.create! name: name, email: email, password: password,
    password_confirmation: password, activated: true, activated_at: Time.zone.now
end
