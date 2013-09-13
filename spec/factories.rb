FactoryGirl.define do 
	factory :user do
		name     "Funny Bunny"
		email    "michael@example.com"
		password "foobar123"
		password_confirmation "foobar123"
	end
end