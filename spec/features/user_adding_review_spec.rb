require 'rails_helper'


feature "User can add a review" do 
	scenario "reviewing a business" do 
		kfc = Fabricate(:business)
		login

		visit root_path
		expect(page).to_not have_content(kfc.name)

		go_to_business_page(kfc)
		expect_link_to_be_visible("Write a Review")
		go_to_new_review_page
		create_review('4 stars', "finger lickin' good")

		expect(page).to have_content(kfc.name)

		go_to_business_page(kfc)
		expect_link_to_not_be_visible('Write a Review')
	end

	def go_to_business_page(business)
		visit business_path(business)
	end

	def go_to_new_review_page
		click_link 'Write a Review'
	end

	def create_review(review, review_description)
		select review, from: 'Rating'
		find('#review_description').set(review_description)
		click_on 'Save'
	end
end
