require 'rails_helper'

describe ReviewsController do 
	let(:kfc) { Fabricate(:business) }
	describe 'GET new' do
		
		it "sets @review variable" do 
			set_current_user
			get :new, business_id: kfc.id 
			expect(assigns(:review)).to be_instance_of(Review)
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