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