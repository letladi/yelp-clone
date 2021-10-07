require "rails_helper"

feature "User can add a business" do
  scenario "user adds business when there are no categories" do
    visit root_path
    login

    category_name = "food"
    business_name = "KFC"

    go_to_new_business_page
    expect(page).to have_content("Please create a category for your business before adding the business.")

    create_new_category(category_name)

    expect(page).to have_content("new category was created successfully.")
    go_to_new_business_page

    create_new_business(business_name, category_name)

    visit businesses_path
    expect(page).to have_content(business_name)
  end
  scenario "user adds business when there are categories" do
    food = Fabricate(:category)

    visit root_path
    login

    go_to_new_business_page

    business_name = "KFC"
    create_new_business(business_name, food.name)

    visit businesses_path
    expect(page).to have_content(business_name)
  end

  def go_to_new_business_page
    click_link "Add Business"
  end

  def create_new_business(name, category_name)
    find("input[name='business[name]']").set(name)
    select category_name, from: "business_category_id"
    click_button "Save"
  end

  def create_new_category(name)
    find("input[name='category[name]']").set(name)
    find("input[type=submit]").click
  end
end
