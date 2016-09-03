require 'rails_helper'

describe ReviewsController do 
	let(:kfc) { Fabricate(:business) }
	describe 'GET new' do
		it "sets @business variable" do 
			set_current_user
			get :new, business_id: kfc.id 
			expect(assigns(:business)).to be_instance_of(Business)
		end
		it "sets @review variable" do
			set_current_user
			get :new, business_id: kfc.id
			expect(assigns(:review)).to be_instance_of(Review) 
		end
		context "specified business does not exist" do 
			before do |example|
				unless example.metadata[:skip_before]
					set_current_user
					request.env["HTTP_REFERER"] = businesses_path
					get :new, business_id: 'uuid-doodle'
				end
			end
			it "goes to the previous page if the specified business does not exist" do 			
				expect(response).to redirect_to request.env['HTTP_REFERER']
			end
			it "redirects to the root path if there is no previous page", skip_before: true do
				set_current_user
				get :new, business_id: 'uuid-doodle'
				expect(response).to redirect_to root_path
			end
			it_behaves_like "error_message_is_set"
		end
		it_behaves_like "require_login" do 
			let(:action) { get :new, business_id: kfc.id  }
		end
	end

	describe 'POST create' do 
		it_behaves_like "require_login" do 
			let(:action) { post :create, review: Fabricate.attributes_for(:review, user_id: nil), business_id: kfc.id }
		end
		context "with valid inputs" do 
			before do
				set_current_user
				post :create, review: Fabricate.attributes_for(:review, user_id: nil), business_id: kfc.id 
			end
			it_behaves_like "redirects_to_root_path"
			it_behaves_like "success_message_is_set"
			it "creates a new review for a business" do 
				expect(kfc.reviews.size).to eq(1)
			end
		end
		context "with invalid inputs" do
			before do
				set_current_user
				post :create, review: Fabricate.attributes_for(:review, user_id: nil, rating: 0), business_id: kfc.id 
			end
		  it_behaves_like "error_message_is_set"
		  it_behaves_like "new_template_is_rendered_again" 
		end
	end
end