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

shared_examples "success_message_is_set" do 
	it "sets a success message" do 
		expect(flash[:success]).to be
	end
end

shared_examples "error_message_is_set" do 
	it "sets an error message" do
		expect(flash[:danger]).to be 
	end
end

shared_examples "redirects_to_root_path" do 
	it "redirects to the root path" do 
		expect(response).to redirect_to root_path
	end
end

shared_examples "new_template_is_rendered_again" do 
	it "renders the new template again" do 
		expect(response).to render_template :new
	end
end

shared_examples "goes_back_to_previous_path_or_root_path" do
	before do |example|
		unless example.metadata[:skip_before]
			set_current_user
			request.env["HTTP_REFERER"] = previous_path
			action
		end
	end
	it "goes to the previous page if the specified business does not exist" do 			
		expect(response).to redirect_to request.env['HTTP_REFERER']
	end
	it "redirects to the root path if there is no previous page", skip_before: true do
		set_current_user
		action
		expect(response).to redirect_to root_path
	end
	it_behaves_like "error_message_is_set"
end