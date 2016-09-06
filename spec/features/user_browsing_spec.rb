require 'rails_helper'

feature "User browsing the application" do 
	scenario "user logged in" do
		visit root_path
    expect(page).to have_content('Yelp')
    expect(page).to have_content('Sign Up')
    expect(page).to have_content('Log In')
    expect(page).to have_content('Recent Reviews')
    expect(page).to have_content('All Businesses')

    expect(page).to_not have_content('Write a Review')
    expect(page).to_not have_content('Add Business')
    expect(page).to_not have_content('Add Business Category')
	end

	scenario 'user not logged in' do 
    bob = Fabricate(:user, first_name: 'Bob')
    kfc = Fabricate(:business)

    login(bob)

    expect(page).to_not have_content('Sign Up')
    expect(page).to_not have_content('Log In')
    expect(page).to_not have_content('Write a Review')

    expect(page).to have_content('Yelp')
    expect(page).to have_content('Bob')
    expect(page).to have_content('Recent Reviews')
    expect(page).to have_content('All Businesses')

    expect(page).to have_content('Add Business')
    expect(page).to have_content('Add Business Category')

    visit businesses_path

    expect(page).to have_content(kfc.name)
    expect(page).to have_content('Add Review')

    click_link(kfc.name)

    expect(page).to have_content('Write a Review')

  end
end