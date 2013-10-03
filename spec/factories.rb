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
	
		
		sequence(:content) { |n| "#{n}" * 140 }
		user

	end

	factory :update do
		sequence(:title) { |n| "Title #{n}"  }
		sequence(:description) { |n| "Description #{n}" }
		user
		idea
	end

	factory :idea do
		sequence(:title) { |n| "Title #{n}"  }
		sequence(:description) { |n| "Description #{n}" }
		owner_id 1
		# user
	end

	factory :tag do
		sequence(:name) { |n| "Name #{n}"}
		# update
		# idea
	end

	factory :pin do 
		description "Build the next Facebook"
		user
	end
end