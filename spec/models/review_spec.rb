require 'rails_helper'

describe Review do 
	it { should belong_to(:business) }
	it { should belong_to(:user) }
	it { should validate_presence_of(:rating) }
	it { should validate_inclusion_of(:rating).in_range(1..5) }
	it { should validate_presence_of(:description) }
	it { should validate_uniqueness_of(:user_id).scoped_to(:business_id) }

	describe 'recent_reviews' do
		it "returns an empty array if there are no reviews" do 
			expect(Review.recent_reviews).to be_empty
		end
		it "if there are less than 6 reviews, it returns all of them" do 
			3.times { Fabricate(:review) }
			expect(Review.recent_reviews.size).to eq(3)
		end
		it "if there are 6 reviews, it returns all of them" do 
			6.times { Fabricate(:review) }
			expect(Review.recent_reviews.size).to eq(6)
		end
		it "returns only 6 reviews if there are more than 6 reviews" do 
			8.times { Fabricate(:review) }
			expect(Review.recent_reviews.size).to eq(6)
		end
		
		
		it "returns the reviews in descending order by creation date" do 
			review1 = Fabricate(:review)
			review2 = Fabricate(:review)
			expect(Review.recent_reviews).to eq([review2, review1])
		end
	end
end