require "rails_helper"

describe UsersController do
  describe "GET new" do
    it "set @user variable" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "GET show" do
    context "specified user does not exist" do
      it_behaves_like "goes_back_to_previous_path_or_root_path" do
        let(:previous_path) { root_path }
        let(:action) { get :show, id: "uudi-doodle" }
      end
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      it "creates a new user" do
        bob = Fabricate.attributes_for(:user)
        post :create, user: bob
        expect(User.count).to eq(1)
      end
      it "sets a success flash" do
        bob = Fabricate.attributes_for(:user)
        post :create, user: bob
        expect(flash[:success]).to be_truthy
      end
      it "redirects to the root path" do
        bob = Fabricate.attributes_for(:user)
        post :create, user: bob
        expect(response).to redirect_to root_path
      end
      it "logs in user" do
        bob = Fabricate.attributes_for(:user)
        post :create, user: bob
        expect(session[:user_id]).to be
      end
    end
    context "with invalid inputs" do
      it "renders the registration page again" do
        bob = Fabricate.attributes_for(:user)
        bob[:first_name] = nil
        post :create, user: bob
        expect(response).to render_template "users/new"
      end
      it "sets an error page" do
        bob = Fabricate.attributes_for(:user)
        bob[:first_name] = nil
        post :create, user: bob
        expect(flash[:danger]).to be
      end
      it "does not create a user" do
        bob = Fabricate.attributes_for(:user)
        bob[:first_name] = nil
        post :create, user: bob
        expect(User.count).to eq(0)
      end
    end
  end
end
