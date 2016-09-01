require 'rails_helper'

describe Business do
	it { should validate_presence_of(:name) }
	it { should belong_to(:category) }
	it { should have_many(:reviews) }

	describe "#rating" do
		it "returns the average for the all the reviews" do 
			business = Fabricate(:business)
			review1 = Fabricate(:review, rating: 4, business: business) 
		  review2 = Fabricate(:review, rating: 2, business: business) 
		  review3 = Fabricate(:review, rating: 2, business: business)
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
			review1 = Fabricate(:review, rating: 4, business: business) 
		  review2 = Fabricate(:review, rating: 2, business: business) 
		  review3 = Fabricate(:review, rating: 2, business: business)
		  expect(business.review_count).to eq(3)
		end
		it "returns 0 there are no reviews" do 
			business = Fabricate(:business)
			expect(business.review_count).to eq(0)
		end
	end
end