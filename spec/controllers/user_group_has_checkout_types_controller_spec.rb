require 'spec_helper'
require 'sunspot/rails/spec_helper'

describe UserGroupHasCheckoutTypesController do
  fixtures :all
  disconnect_sunspot

  describe "GET index" do
    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      it "assigns all user_group_has_checkout_types as @user_group_has_checkout_types" do
        get :index
        assigns(:user_group_has_checkout_types).should eq(UserGroupHasCheckoutType.includes([:user_group, :checkout_type]).order('user_groups.position, checkout_types.position').page(1))
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      it "assigns all user_group_has_checkout_types as @user_group_has_checkout_types" do
        get :index
        assigns(:user_group_has_checkout_types).should eq(UserGroupHasCheckoutType.includes([:user_group, :checkout_type]).order('user_groups.position, checkout_types.position').page(1))
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      it "assigns all user_group_has_checkout_types as @user_group_has_checkout_types" do
        get :index
        assigns(:user_group_has_checkout_types).should be_empty
        response.should be_forbidden
      end
    end

    describe "When not logged in" do
      it "assigns all user_group_has_checkout_types as @user_group_has_checkout_types" do
        get :index
        assigns(:user_group_has_checkout_types).should be_empty
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "GET show" do
    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      it "assigns the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
        user_group_has_checkout_type = FactoryGirl.create(:user_group_has_checkout_type)
        get :show, :id => user_group_has_checkout_type.id
        assigns(:user_group_has_checkout_type).should eq(user_group_has_checkout_type)
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      it "assigns the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
        user_group_has_checkout_type = FactoryGirl.create(:user_group_has_checkout_type)
        get :show, :id => user_group_has_checkout_type.id
        assigns(:user_group_has_checkout_type).should eq(user_group_has_checkout_type)
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      it "assigns the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
        user_group_has_checkout_type = FactoryGirl.create(:user_group_has_checkout_type)
        get :show, :id => user_group_has_checkout_type.id
        assigns(:user_group_has_checkout_type).should eq(user_group_has_checkout_type)
      end
    end

    describe "When not logged in" do
      it "assigns the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
        user_group_has_checkout_type = FactoryGirl.create(:user_group_has_checkout_type)
        get :show, :id => user_group_has_checkout_type.id
        assigns(:user_group_has_checkout_type).should eq(user_group_has_checkout_type)
      end
    end
  end

  describe "GET new" do
    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      it "assigns the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
        get :new
        assigns(:user_group_has_checkout_type).should_not be_valid
        response.should be_success
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      it "should not assign the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
        get :new
        assigns(:user_group_has_checkout_type).should_not be_valid
        response.should be_forbidden
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      it "should not assign the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
        get :new
        assigns(:user_group_has_checkout_type).should_not be_valid
        response.should be_forbidden
      end
    end

    describe "When not logged in" do
      it "should not assign the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
        get :new
        assigns(:user_group_has_checkout_type).should_not be_valid
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "GET edit" do
    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      it "assigns the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
        user_group_has_checkout_type = FactoryGirl.create(:user_group_has_checkout_type)
        get :edit, :id => user_group_has_checkout_type.id
        assigns(:user_group_has_checkout_type).should eq(user_group_has_checkout_type)
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      it "assigns the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
        user_group_has_checkout_type = FactoryGirl.create(:user_group_has_checkout_type)
        get :edit, :id => user_group_has_checkout_type.id
        response.should be_forbidden
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      it "assigns the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
        user_group_has_checkout_type = FactoryGirl.create(:user_group_has_checkout_type)
        get :edit, :id => user_group_has_checkout_type.id
        response.should be_forbidden
      end
    end

    describe "When not logged in" do
      it "should not assign the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
        user_group_has_checkout_type = FactoryGirl.create(:user_group_has_checkout_type)
        get :edit, :id => user_group_has_checkout_type.id
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "POST create" do
    before(:each) do
      @attrs = FactoryGirl.attributes_for(:user_group_has_checkout_type)
      @invalid_attrs = {:user_group_id => ''}
    end

    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      describe "with valid params" do
        it "assigns a newly created user_group_has_checkout_type as @user_group_has_checkout_type" do
          post :create, :user_group_has_checkout_type => @attrs
          assigns(:user_group_has_checkout_type).should be_valid
        end

        it "redirects to the created patron" do
          post :create, :user_group_has_checkout_type => @attrs
          response.should redirect_to(assigns(:user_group_has_checkout_type))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved user_group_has_checkout_type as @user_group_has_checkout_type" do
          post :create, :user_group_has_checkout_type => @invalid_attrs
          assigns(:user_group_has_checkout_type).should_not be_valid
        end

        it "should be successful" do
          post :create, :user_group_has_checkout_type => @invalid_attrs
          response.should be_success
        end
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      describe "with valid params" do
        it "assigns a newly created user_group_has_checkout_type as @user_group_has_checkout_type" do
          post :create, :user_group_has_checkout_type => @attrs
          assigns(:user_group_has_checkout_type).should be_valid
        end

        it "should be forbidden" do
          post :create, :user_group_has_checkout_type => @attrs
          response.should be_forbidden
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved user_group_has_checkout_type as @user_group_has_checkout_type" do
          post :create, :user_group_has_checkout_type => @invalid_attrs
          assigns(:user_group_has_checkout_type).should_not be_valid
        end

        it "should be forbidden" do
          post :create, :user_group_has_checkout_type => @invalid_attrs
          response.should be_forbidden
        end
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      describe "with valid params" do
        it "assigns a newly created user_group_has_checkout_type as @user_group_has_checkout_type" do
          post :create, :user_group_has_checkout_type => @attrs
          assigns(:user_group_has_checkout_type).should be_valid
        end

        it "should be forbidden" do
          post :create, :user_group_has_checkout_type => @attrs
          response.should be_forbidden
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved user_group_has_checkout_type as @user_group_has_checkout_type" do
          post :create, :user_group_has_checkout_type => @invalid_attrs
          assigns(:user_group_has_checkout_type).should_not be_valid
        end

        it "should be forbidden" do
          post :create, :user_group_has_checkout_type => @invalid_attrs
          response.should be_forbidden
        end
      end
    end

    describe "When not logged in" do
      describe "with valid params" do
        it "assigns a newly created user_group_has_checkout_type as @user_group_has_checkout_type" do
          post :create, :user_group_has_checkout_type => @attrs
          assigns(:user_group_has_checkout_type).should be_valid
        end

        it "should be forbidden" do
          post :create, :user_group_has_checkout_type => @attrs
          response.should redirect_to(new_user_session_url)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved user_group_has_checkout_type as @user_group_has_checkout_type" do
          post :create, :user_group_has_checkout_type => @invalid_attrs
          assigns(:user_group_has_checkout_type).should_not be_valid
        end

        it "should be forbidden" do
          post :create, :user_group_has_checkout_type => @invalid_attrs
          response.should redirect_to(new_user_session_url)
        end
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @user_group_has_checkout_type = FactoryGirl.create(:user_group_has_checkout_type)
      @attrs = FactoryGirl.attributes_for(:user_group_has_checkout_type)
      @invalid_attrs = {:user_group_id => ''}
    end

    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      describe "with valid params" do
        it "updates the requested user_group_has_checkout_type" do
          put :update, :id => @user_group_has_checkout_type.id, :user_group_has_checkout_type => @attrs
        end

        it "assigns the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
          put :update, :id => @user_group_has_checkout_type.id, :user_group_has_checkout_type => @attrs
          assigns(:user_group_has_checkout_type).should eq(@user_group_has_checkout_type)
        end
      end

      describe "with invalid params" do
        it "assigns the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
          put :update, :id => @user_group_has_checkout_type.id, :user_group_has_checkout_type => @invalid_attrs
          response.should render_template("edit")
        end
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      describe "with valid params" do
        it "updates the requested user_group_has_checkout_type" do
          put :update, :id => @user_group_has_checkout_type.id, :user_group_has_checkout_type => @attrs
        end

        it "assigns the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
          put :update, :id => @user_group_has_checkout_type.id, :user_group_has_checkout_type => @attrs
          assigns(:user_group_has_checkout_type).should eq(@user_group_has_checkout_type)
          response.should be_forbidden
        end
      end

      describe "with invalid params" do
        it "assigns the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
          put :update, :id => @user_group_has_checkout_type.id, :user_group_has_checkout_type => @invalid_attrs
          response.should be_forbidden
        end
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      describe "with valid params" do
        it "updates the requested user_group_has_checkout_type" do
          put :update, :id => @user_group_has_checkout_type.id, :user_group_has_checkout_type => @attrs
        end

        it "assigns the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
          put :update, :id => @user_group_has_checkout_type.id, :user_group_has_checkout_type => @attrs
          assigns(:user_group_has_checkout_type).should eq(@user_group_has_checkout_type)
          response.should be_forbidden
        end
      end

      describe "with invalid params" do
        it "assigns the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
          put :update, :id => @user_group_has_checkout_type.id, :user_group_has_checkout_type => @invalid_attrs
          response.should be_forbidden
        end
      end
    end

    describe "When not logged in" do
      describe "with valid params" do
        it "updates the requested user_group_has_checkout_type" do
          put :update, :id => @user_group_has_checkout_type.id, :user_group_has_checkout_type => @attrs
        end

        it "should be forbidden" do
          put :update, :id => @user_group_has_checkout_type.id, :user_group_has_checkout_type => @attrs
          response.should redirect_to(new_user_session_url)
        end
      end

      describe "with invalid params" do
        it "assigns the requested user_group_has_checkout_type as @user_group_has_checkout_type" do
          put :update, :id => @user_group_has_checkout_type.id, :user_group_has_checkout_type => @invalid_attrs
          response.should redirect_to(new_user_session_url)
        end
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @user_group_has_checkout_type = FactoryGirl.create(:user_group_has_checkout_type)
    end

    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      it "destroys the requested user_group_has_checkout_type" do
        delete :destroy, :id => @user_group_has_checkout_type.id
      end

      it "redirects to the user_group_has_checkout_types list" do
        delete :destroy, :id => @user_group_has_checkout_type.id
        response.should redirect_to(user_group_has_checkout_types_url)
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      it "destroys the requested user_group_has_checkout_type" do
        delete :destroy, :id => @user_group_has_checkout_type.id
      end

      it "should be forbidden" do
        delete :destroy, :id => @user_group_has_checkout_type.id
        response.should be_forbidden
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      it "destroys the requested user_group_has_checkout_type" do
        delete :destroy, :id => @user_group_has_checkout_type.id
      end

      it "should be forbidden" do
        delete :destroy, :id => @user_group_has_checkout_type.id
        response.should be_forbidden
      end
    end

    describe "When not logged in" do
      it "destroys the requested user_group_has_checkout_type" do
        delete :destroy, :id => @user_group_has_checkout_type.id
      end

      it "should be forbidden" do
        delete :destroy, :id => @user_group_has_checkout_type.id
        response.should redirect_to(new_user_session_url)
      end
    end
  end
end
