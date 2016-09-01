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
		it_behaves_like "require_login" do
			let(:action) { post :create, category: Fabricate.attributes_for(:category)  }
		end
		context "with valid input" do 
			before do 
				post :create, category:  Fabricate.attributes_for(:category) 
			end
			it "redirects to the root path" do
				expect(response).to redirect_to root_path
			end
			it "creates a new category" do 
				expect(Category.count).to eq(1)
			end
			it "sets success error message" do 
				expect(flash[:success]).to be
			end
		end
		context "with invalid inputs" do 
			before do 
				post :create, category: Fabricate.attributes_for(:category, name: '') 
			end
			it "sets error message" do 
				expect(flash[:danger]).to be
			end
			it "does not create a category" do 
				expect(Category.count).to eq(0)
			end
			it "renders the new template" do 
				expect(response).to render_template :new
			end
		end
	end
end