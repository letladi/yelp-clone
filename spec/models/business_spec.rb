require 'rails_helper'

describe Business do
	it { should validate_presence_of(:name) }
	it { should belong_to(:category) }
	it { should have_many(:reviews) }

	describe "#rating" do
		it "returns the average for the all the reviews" do 
			business = Fabricate(:business)
			Fabricate(:review, rating: 4, business: business) 
		  Fabricate(:review, rating: 2, business: business) 
		  Fabricate(:review, rating: 2, business: business)
			expect(business.rating).to eq(2.7)
		end
		it "returns zero if there are no reviews" do
			business = Fabricate(:business)
			expect(business.rating).to eq(0.0)
		end
	end

	describe "#review_count" do
		it "returns the number of reviews associated with a business" do
			business = Fabricate(:business)
			Fabricate(:review, rating: 4, business: business) 
		  Fabricate(:review, rating: 2, business: business) 
		  Fabricate(:review, rating: 2, business: business)
		  expect(business.review_count).to eq(3)
		end
		it "returns 0 there are no reviews" do 
			business = Fabricate(:business)
			expect(business.review_count).to eq(0)
		end
	end

	describe "#reviewed_by?(user)" do 
		it "returns true if the user has already reviewed the user" do 
			kfc = Fabricate(:business)
			bob = Fabricate(:user)
			review = Fabricate(:review, business: kfc, user: bob)
			expect(kfc.reviewed_by?(bob)).to be_truthy
		end
		it "returns false if the user has not reviewed the business" do 
			kfc = Fabricate(:business)
			bob = Fabricate(:user)
			review = Fabricate(:review, business: kfc)
			expect(kfc.reviewed_by?(bob)).to be_falsy
		end
	end
end