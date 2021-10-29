User.create!(name: 'Example User',
             email: 'example@example.com',
             password: 'foobar',
             password_confirmation: 'foobar',
             activated: true,
             admin: true)

Expertise.create!(name: 'Level One')
Expertise.create!(name: 'Level Two')
Expertise.create!(name: 'Weightlifting')
Expertise.create!(name: 'Barbell Course')
Expertise.create!(name: 'Skill Aquisition')

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n}@railstutorial.com"
  password = 'foobar'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true)
end