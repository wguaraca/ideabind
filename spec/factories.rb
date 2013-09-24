FactoryGirl.define do 
	factory :user do
		sequence(:name)  { |n| "Person #{n}" }
		sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar123"
		password_confirmation "foobar123"

		factory :admin do
			admin true
		end
	end

	factory :comment do
		sequence(:user_id) { |n| n } # Shouldn't be mass-assignable
		sequence(:update_id) { |n| n }
		sequence(:par_comment_id) { |n| n }
	
		
		content "Lorem Ipsum"
		user

	end

	factory :pin do 
		description "Build the next Facebook"
		user
	end
end