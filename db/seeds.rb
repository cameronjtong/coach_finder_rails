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
Expertise.create!(name: 'Skill Acquisition')
Expertise.create!(name: 'Crossfit L1')
Expertise.create!(name: 'CSCS')
Expertise.create!(name: 'CPT')

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

users = User.order(:created_at).take(6)

50.times do
  content = Faker::Lorem.sentence(word_count: 10)
  users.each {|user| user.microposts.create!(content: content)}
end