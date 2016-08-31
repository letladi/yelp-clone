require 'rails_helper'

describe SessionsController do 
	describe "POST create" do 
		context "with valid inputs" do 
			it "sets session to the user id" do 
				bob = Fabricate(:user)
				post :create, params: { email: bob.email, password: bob.password }
				expect(session[:user_id]).to be
			end
			it "redirects to the root path" do
				bob = Fabricate(:user)
				post :create, params: { email: bob.email, password: bob.password }
				expect(response).to redirect_to root_path
			end
			it "sets a success message" do
			  bob = Fabricate(:user)
				post :create, params: { email: bob.email, password: bob.password }
				expect(flash[:success]).to be
			end
		end
		context "with invalid inputs" do
			it "renders the login page" do
				bob = Fabricate(:user)
				post :create, params: { email: bob.email, password: bob.password + 'wrong-word' }
				expect(response).to render_template :new
			end
			it "sets error message" do 
				bob = Fabricate(:user)
				post :create, params: { email: bob.email, password: bob.password + 'wrong-word' }
				expect(flash[:error]).to be
			end
		end
	end
	describe "DELETE destroy" do
		before do 
			bob = Fabricate(:user)
			session[:user_id] = bob.id
		end
		it "removes user id from session" do 
			delete :destroy
			expect(session[:user_id]).to be_nil
		end
		it "redirects to the root path" do 
			delete :destroy
			expect(response).to redirect_to root_path
		end
		it "sets informational message" do 
			delete :destroy
			expect(flash[:info]).to_not be_nil
		end
	end
end