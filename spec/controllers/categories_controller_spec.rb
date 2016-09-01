require 'rails_helper'

describe CategoriesController do
	before do
		set_current_user 
	end
	describe 'GET new' do 
		it "sets @category variable" do
			get :new
			expect(assigns(:category)).to be_instance_of(Category) 
		end

		it_behaves_like "require_login" do
			let(:action) { get :new }
		end
	end 

	describe 'POST create' do
		before do 
			post :create, params: { name: Fabricate(:category) }
		end
		it "redirects to the root path" do
			
		end
		it "creates a new category"
		it_behaves_like "require_login" do
			let(:action) { get :new }
		end
	end
end