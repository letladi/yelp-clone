require 'rails_helper'

describe BusinessController do 
	before do 
		set_current_user
	end

	describe "GET index" do 
		it "sets the @businesses variable, which is all the businesses in the database" do 
			2.times do 
				Fabricate(:business)
			end
			get :index
			expect(assigns(:businesses)).to eq(Business.all)
		end
	end

	describe "GET new" do
		before do
			get :new
		end
		it_behaves_like "require_login" do 
			let(:action) { get :new }
		end
		it "sets @business variable" do
			expect(assigns(:business)).to be_truthy
		end
	end

	describe "POST create" do 
		it_behaves_like "require_login" do
			food = Fabricate(:category)
		  let(:action) { post :create, business: Fabricate.attributes_for(:business, category_id: food.id) }
		end
		context "with valid inputs" do 
			before do 
				food = Fabricate(:category)
				post :create, business: Fabricate.attributes_for(:business, category_id: food.id) 
			end
			it_behaves_like "redirects_to_root_path"
			it "create a new business" do 
				expect(Business.count).to eq(1)
			end
			it_behaves_like "success_message_is_set"
		end
		context "with invalid inputs" do 
			before do 
				food = Fabricate(:category)
				post :create, business: Fabricate.attributes_for(:business, name: '') 
			end
			it "does not create a business" do 
				expect(Business.count).to eq(0)
			end
			it "renders the new template" do 
				expect(response).to render_template :new
			end
			it_behaves_like "error_message_is_set"
		end
	end
end