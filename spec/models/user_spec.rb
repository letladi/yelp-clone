require 'rails_helper'

describe User do
	it { should validate_presence_of(:first_name) }
	it { should validate_presence_of(:last_name) }
	it { should validate_presence_of(:email) }
	it { should validate_presence_of(:password) }
	it { should have_many(:reviews) }
	it { should have_secure_password }

	describe "#review_count" do
		it "returns the total number of reviews posted by the user" do 
			bob = Fabricate(:user)
			kfc = Fabricate(:business)
			mcD = Fabricate(:business)
			review1 = Fabricate(:review, business: kfc, user: bob)
			review2 = Fabricate(:review, business: mcD, user: bob)
			expect(bob.review_count).to eq(2)
		end
		it "returns zero if the user has not posted any reviews" do 
			bob = Fabricate(:user)
			expect(bob.review_count).to eq(0)
		end
	end

	describe "#full_name" do 
		it "returns the first and last names concatenated" do 
			bob = Fabricate(:user, first_name: 'Bob', last_name: 'Cocker')
			expect(bob.full_name).to eq('Bob Cocker')
		end
	end
end