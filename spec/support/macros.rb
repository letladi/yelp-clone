def clear_current_user
  session[:user_id] = nil
end

def set_current_user
  bob = Fabricate(:user)
  session[:user_id] = bob.id
end

def get_current_user
  User.find(session[:user_id])
end

def login(a_user = nil)
  user = a_user || Fabricate(:user)
  visit login_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Login"
end

def expect_link_to_be_visible(link_text)
  expect(page).to have_content(link_text)
end

def expect_link_to_not_be_visible(link_text)
  expect(page).to_not have_content(link_text)
end
