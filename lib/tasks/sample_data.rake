namespace :db do 
	desc "Fill database with sample data"
	task populate: :environment do
		admin = User.create!(name:  "Edderic",
												 email: "edderic@gmail.com",
												 password: "proteinbar",
												 password_confirmation: "proteinbar")
		admin.update_attribute(:admin, true)


		User.create!(name: "Some user",
								 email: "funny@railstutorial.org",
								 password: "foobar123",
								 password_confirmation: "foobar123")


		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(name: name,
									 email: email,
									 password: password,
									 password_confirmation: password)
		end
	

	
		users = User.all(limit: 6)
		50.times do
			content = Faker::Lorem.sentence(5)
			users.each { |user| user.pins.create!(description: content) }
		end
	end
end