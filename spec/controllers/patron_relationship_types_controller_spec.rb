require 'spec_helper'
require 'sunspot/rails/spec_helper'

describe PatronRelationshipTypesController do
  fixtures :all
  disconnect_sunspot

  describe "GET index" do
    before(:each) do
      FactoryGirl.create(:patron_relationship_type)
    end

    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      it "assigns all patron_relationship_types as @patron_relationship_types" do
        get :index
        assigns(:patron_relationship_types).should eq(PatronRelationshipType.all)
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      it "assigns all patron_relationship_types as @patron_relationship_types" do
        get :index
        assigns(:patron_relationship_types).should eq(PatronRelationshipType.all)
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      it "assigns all patron_relationship_types as @patron_relationship_types" do
        get :index
        assigns(:patron_relationship_types).should eq(PatronRelationshipType.all)
      end
    end

    describe "When not logged in" do
      it "assigns all patron_relationship_types as @patron_relationship_types" do
        get :index
        assigns(:patron_relationship_types).should eq(PatronRelationshipType.all)
      end
    end
  end

  describe "GET show" do
    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      it "assigns the requested patron_relationship_type as @patron_relationship_type" do
        patron_relationship_type = FactoryGirl.create(:patron_relationship_type)
        get :show, :id => patron_relationship_type.id
        assigns(:patron_relationship_type).should eq(patron_relationship_type)
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      it "assigns the requested patron_relationship_type as @patron_relationship_type" do
        patron_relationship_type = FactoryGirl.create(:patron_relationship_type)
        get :show, :id => patron_relationship_type.id
        assigns(:patron_relationship_type).should eq(patron_relationship_type)
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      it "assigns the requested patron_relationship_type as @patron_relationship_type" do
        patron_relationship_type = FactoryGirl.create(:patron_relationship_type)
        get :show, :id => patron_relationship_type.id
        assigns(:patron_relationship_type).should eq(patron_relationship_type)
      end
    end

    describe "When not logged in" do
      it "assigns the requested patron_relationship_type as @patron_relationship_type" do
        patron_relationship_type = FactoryGirl.create(:patron_relationship_type)
        get :show, :id => patron_relationship_type.id
        assigns(:patron_relationship_type).should eq(patron_relationship_type)
      end
    end
  end

  describe "GET new" do
    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      it "assigns the requested patron_relationship_type as @patron_relationship_type" do
        get :new
        assigns(:patron_relationship_type).should_not be_valid
        response.should be_success
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      it "should not assign the requested patron_relationship_type as @patron_relationship_type" do
        get :new
        assigns(:patron_relationship_type).should_not be_valid
        response.should be_forbidden
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      it "should not assign the requested patron_relationship_type as @patron_relationship_type" do
        get :new
        assigns(:patron_relationship_type).should_not be_valid
        response.should be_forbidden
      end
    end

    describe "When not logged in" do
      it "should not assign the requested patron_relationship_type as @patron_relationship_type" do
        get :new
        assigns(:patron_relationship_type).should_not be_valid
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "GET edit" do
    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      it "assigns the requested patron_relationship_type as @patron_relationship_type" do
        patron_relationship_type = FactoryGirl.create(:patron_relationship_type)
        get :edit, :id => patron_relationship_type.id
        assigns(:patron_relationship_type).should eq(patron_relationship_type)
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      it "assigns the requested patron_relationship_type as @patron_relationship_type" do
        patron_relationship_type = FactoryGirl.create(:patron_relationship_type)
        get :edit, :id => patron_relationship_type.id
        response.should be_forbidden
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      it "assigns the requested patron_relationship_type as @patron_relationship_type" do
        patron_relationship_type = FactoryGirl.create(:patron_relationship_type)
        get :edit, :id => patron_relationship_type.id
        response.should be_forbidden
      end
    end

    describe "When not logged in" do
      it "should not assign the requested patron_relationship_type as @patron_relationship_type" do
        patron_relationship_type = FactoryGirl.create(:patron_relationship_type)
        get :edit, :id => patron_relationship_type.id
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "POST create" do
    before(:each) do
      @attrs = FactoryGirl.attributes_for(:patron_relationship_type)
      @invalid_attrs = {:name => ''}
    end

    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      describe "with valid params" do
        it "assigns a newly created patron_relationship_type as @patron_relationship_type" do
          post :create, :patron_relationship_type => @attrs
          assigns(:patron_relationship_type).should be_valid
        end

        it "redirects to the created patron" do
          post :create, :patron_relationship_type => @attrs
          response.should redirect_to(assigns(:patron_relationship_type))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved patron_relationship_type as @patron_relationship_type" do
          post :create, :patron_relationship_type => @invalid_attrs
          assigns(:patron_relationship_type).should_not be_valid
        end

        it "should be successful" do
          post :create, :patron_relationship_type => @invalid_attrs
          response.should be_success
        end
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      describe "with valid params" do
        it "assigns a newly created patron_relationship_type as @patron_relationship_type" do
          post :create, :patron_relationship_type => @attrs
          assigns(:patron_relationship_type).should be_valid
        end

        it "should be forbidden" do
          post :create, :patron_relationship_type => @attrs
          response.should be_forbidden
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved patron_relationship_type as @patron_relationship_type" do
          post :create, :patron_relationship_type => @invalid_attrs
          assigns(:patron_relationship_type).should_not be_valid
        end

        it "should be forbidden" do
          post :create, :patron_relationship_type => @invalid_attrs
          response.should be_forbidden
        end
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      describe "with valid params" do
        it "assigns a newly created patron_relationship_type as @patron_relationship_type" do
          post :create, :patron_relationship_type => @attrs
          assigns(:patron_relationship_type).should be_valid
        end

        it "should be forbidden" do
          post :create, :patron_relationship_type => @attrs
          response.should be_forbidden
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved patron_relationship_type as @patron_relationship_type" do
          post :create, :patron_relationship_type => @invalid_attrs
          assigns(:patron_relationship_type).should_not be_valid
        end

        it "should be forbidden" do
          post :create, :patron_relationship_type => @invalid_attrs
          response.should be_forbidden
        end
      end
    end

    describe "When not logged in" do
      describe "with valid params" do
        it "assigns a newly created patron_relationship_type as @patron_relationship_type" do
          post :create, :patron_relationship_type => @attrs
          assigns(:patron_relationship_type).should be_valid
        end

        it "should be forbidden" do
          post :create, :patron_relationship_type => @attrs
          response.should redirect_to(new_user_session_url)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved patron_relationship_type as @patron_relationship_type" do
          post :create, :patron_relationship_type => @invalid_attrs
          assigns(:patron_relationship_type).should_not be_valid
        end

        it "should be forbidden" do
          post :create, :patron_relationship_type => @invalid_attrs
          response.should redirect_to(new_user_session_url)
        end
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @patron_relationship_type = FactoryGirl.create(:patron_relationship_type)
      @attrs = FactoryGirl.attributes_for(:patron_relationship_type)
      @invalid_attrs = {:name => ''}
    end

    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      describe "with valid params" do
        it "updates the requested patron_relationship_type" do
          put :update, :id => @patron_relationship_type.id, :patron_relationship_type => @attrs
        end

        it "assigns the requested patron_relationship_type as @patron_relationship_type" do
          put :update, :id => @patron_relationship_type.id, :patron_relationship_type => @attrs
          assigns(:patron_relationship_type).should eq(@patron_relationship_type)
        end

        it "moves its position when specified" do
          put :update, :id => @patron_relationship_type.id, :patron_relationship_type => @attrs, :position => 2
          response.should redirect_to(patron_relationship_types_url)
        end
      end

      describe "with invalid params" do
        it "assigns the requested patron_relationship_type as @patron_relationship_type" do
          put :update, :id => @patron_relationship_type.id, :patron_relationship_type => @invalid_attrs
          response.should render_template("edit")
        end
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      describe "with valid params" do
        it "updates the requested patron_relationship_type" do
          put :update, :id => @patron_relationship_type.id, :patron_relationship_type => @attrs
        end

        it "assigns the requested patron_relationship_type as @patron_relationship_type" do
          put :update, :id => @patron_relationship_type.id, :patron_relationship_type => @attrs
          assigns(:patron_relationship_type).should eq(@patron_relationship_type)
          response.should be_forbidden
        end
      end

      describe "with invalid params" do
        it "assigns the requested patron_relationship_type as @patron_relationship_type" do
          put :update, :id => @patron_relationship_type.id, :patron_relationship_type => @invalid_attrs
          response.should be_forbidden
        end
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      describe "with valid params" do
        it "updates the requested patron_relationship_type" do
          put :update, :id => @patron_relationship_type.id, :patron_relationship_type => @attrs
        end

        it "assigns the requested patron_relationship_type as @patron_relationship_type" do
          put :update, :id => @patron_relationship_type.id, :patron_relationship_type => @attrs
          assigns(:patron_relationship_type).should eq(@patron_relationship_type)
          response.should be_forbidden
        end
      end

      describe "with invalid params" do
        it "assigns the requested patron_relationship_type as @patron_relationship_type" do
          put :update, :id => @patron_relationship_type.id, :patron_relationship_type => @invalid_attrs
          response.should be_forbidden
        end
      end
    end

    describe "When not logged in" do
      describe "with valid params" do
        it "updates the requested patron_relationship_type" do
          put :update, :id => @patron_relationship_type.id, :patron_relationship_type => @attrs
        end

        it "should be forbidden" do
          put :update, :id => @patron_relationship_type.id, :patron_relationship_type => @attrs
          response.should redirect_to(new_user_session_url)
        end
      end

      describe "with invalid params" do
        it "assigns the requested patron_relationship_type as @patron_relationship_type" do
          put :update, :id => @patron_relationship_type.id, :patron_relationship_type => @invalid_attrs
          response.should redirect_to(new_user_session_url)
        end
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @patron_relationship_type = FactoryGirl.create(:patron_relationship_type)
    end

    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      it "destroys the requested patron_relationship_type" do
        delete :destroy, :id => @patron_relationship_type.id
      end

      it "redirects to the patron_relationship_types list" do
        delete :destroy, :id => @patron_relationship_type.id
        response.should redirect_to(patron_relationship_types_url)
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      it "destroys the requested patron_relationship_type" do
        delete :destroy, :id => @patron_relationship_type.id
      end

      it "should be forbidden" do
        delete :destroy, :id => @patron_relationship_type.id
        response.should be_forbidden
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      it "destroys the requested patron_relationship_type" do
        delete :destroy, :id => @patron_relationship_type.id
      end

      it "should be forbidden" do
        delete :destroy, :id => @patron_relationship_type.id
        response.should be_forbidden
      end
    end

    describe "When not logged in" do
      it "destroys the requested patron_relationship_type" do
        delete :destroy, :id => @patron_relationship_type.id
      end

      it "should be forbidden" do
        delete :destroy, :id => @patron_relationship_type.id
        response.should redirect_to(new_user_session_url)
      end
    end
  end
end
