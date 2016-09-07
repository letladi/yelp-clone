require 'rails_helper'


feature "User can add a review" do 
	scenario "reviewing a business" do 
		kfc = Fabricate(:business)
		login

		visit root_path
		expect(page).to_not have_content(kfc.name)

		visit business_path(kfc)
		click_link "Write a Review"
		select '4 stars', from: 'Rating'
		find('#review_description').set("finger lickin' good")
		click_on 'Save'

		expect(page).to have_content(kfc.name)

		visit business_path(kfc)
		expect(page).to_not have_content('Write a Review')
	end
end
