shared_examples "require_login" do
	it "redirects to the login path" do 
		clear_current_user
		action
		expect(response).to redirect_to login_path
	end
	it "sets an error message" do 
		clear_current_user
		action
		expect(flash[:danger]).to be
	end
end