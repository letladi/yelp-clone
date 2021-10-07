require "rails_helper"

feature "User browsing the application" do
  scenario "user logged in" do
    visit root_path

    ["Yelp", "Sign Up", "Log In",
     "Recent Reviews", "All Businesses"].each do |link_text|
      expect_link_to_be_visible(link_text)
    end

    ["Write a Review", "Add Business",
     "Add Business Category"].each do |link_text|
      expect_link_to_not_be_visible(link_text)
    end
  end

  scenario "user not logged in" do
    bob = Fabricate(:user, first_name: "Bob")
    kfc = Fabricate(:business)

    login(bob)

    ["Sign Up", "Log In", "Write a Review"].each do |link_text|
      expect_link_to_not_be_visible(link_text)
    end

    ["Yelp", "Bob", "Log Out", "Recent Reviews", "All Businesses",
     "Add Business", "Add Business Category"].each do |link_text|
      expect_link_to_be_visible(link_text)
    end

    visit businesses_path

    [kfc.name, "Add Review"].each do |link_text|
      expect_link_to_be_visible(link_text)
    end

    click_link(kfc.name)

    expect(page).to have_content("Write a Review")
  end
end
