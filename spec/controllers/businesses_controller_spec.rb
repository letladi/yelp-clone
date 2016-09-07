require 'rails_helper'

describe BusinessesController do 
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

	describe "GET show" do 
		it "sets @business variable" do 
			get :show, params: { id: Fabricate(:business).id }
			expect(assigns(:business)).to be_instance_of(Business)
		end
		context "business does not exist" do 
			it_behaves_like "goes_back_to_previous_path_or_root_path" do 
				let(:previous_path) { businesses_path }
				let(:action) { get :show, params: { id: 'uuid-doodle' } }
			end
		end
	end

	describe "GET new" do
		before do |example|
			unless example.metadata[:skip_before]
				Fabricate(:category)
				get :new
			end
		end
		it_behaves_like "require_login" do 
			let(:action) { get :new }
		end
		it "sets @business variable" do
			expect(assigns(:business)).to be_truthy
		end
		context "no categories exist", skip_before: true do 
			before do 
				get :new
			end
		  it "redirects to the new_category path if there are no categories" do 
		  	expect(response).to redirect_to new_category_path
      end
      it_behaves_like "error_message_is_set"
		end
	end

	describe "POST create" do 
		it_behaves_like "require_login" do
			food = Fabricate(:category)
		  let(:action) { post :create, params: { business: Fabricate.attributes_for(:business, category_id: food.id) } }
		end
		context "with valid inputs" do 
			before do 
				food = Fabricate(:category)
				post :create, params: { business: Fabricate.attributes_for(:business, category_id: food.id) }
			end
			it_behaves_like "redirects_to_root_path"
			it "create a new business" do 
				expect(Business.count).to eq(1)
			end
			it_behaves_like "success_message_is_set"
		end
		context "with invalid inputs" do 
			before do 
				post :create, params: { business: Fabricate.attributes_for(:business, name: '') } 
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