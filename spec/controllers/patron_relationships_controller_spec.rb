require 'spec_helper'
require 'sunspot/rails/spec_helper'

describe PatronRelationshipsController do
  fixtures :all
  disconnect_sunspot

  describe "GET index" do
    before(:each) do
      FactoryGirl.create(:patron_relationship)
    end

    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      it "assigns all patron_relationships as @patron_relationships" do
        get :index
        assigns(:patron_relationships).should eq(PatronRelationship.all)
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      it "assigns all patron_relationships as @patron_relationships" do
        get :index
        assigns(:patron_relationships).should eq(PatronRelationship.all)
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      it "assigns all patron_relationships as @patron_relationships" do
        get :index
        assigns(:patron_relationships).should eq(PatronRelationship.all)
      end
    end

    describe "When not logged in" do
      it "assigns all patron_relationships as @patron_relationships" do
        get :index
        assigns(:patron_relationships).should eq(PatronRelationship.all)
      end
    end
  end

  describe "GET show" do
    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      it "assigns the requested patron_relationship as @patron_relationship" do
        patron_relationship = FactoryGirl.create(:patron_relationship)
        get :show, :id => patron_relationship.id
        assigns(:patron_relationship).should eq(patron_relationship)
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      it "assigns the requested patron_relationship as @patron_relationship" do
        patron_relationship = FactoryGirl.create(:patron_relationship)
        get :show, :id => patron_relationship.id
        assigns(:patron_relationship).should eq(patron_relationship)
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      it "assigns the requested patron_relationship as @patron_relationship" do
        patron_relationship = FactoryGirl.create(:patron_relationship)
        get :show, :id => patron_relationship.id
        assigns(:patron_relationship).should eq(patron_relationship)
      end
    end

    describe "When not logged in" do
      it "assigns the requested patron_relationship as @patron_relationship" do
        patron_relationship = FactoryGirl.create(:patron_relationship)
        get :show, :id => patron_relationship.id
        assigns(:patron_relationship).should eq(patron_relationship)
      end
    end
  end

  describe "GET new" do
    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      it "assigns the requested patron_relationship as @patron_relationship" do
        get :new
        assigns(:patron_relationship).should_not be_valid
        response.should be_success
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      it "should not assign the requested patron_relationship as @patron_relationship" do
        get :new
        assigns(:patron_relationship).should_not be_valid
        response.should be_success
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      it "should not assign the requested patron_relationship as @patron_relationship" do
        get :new
        assigns(:patron_relationship).should_not be_valid
        response.should be_forbidden
      end
    end

    describe "When not logged in" do
      it "should not assign the requested patron_relationship as @patron_relationship" do
        get :new
        assigns(:patron_relationship).should_not be_valid
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "GET edit" do
    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      it "assigns the requested patron_relationship as @patron_relationship" do
        patron_relationship = FactoryGirl.create(:patron_relationship)
        get :edit, :id => patron_relationship.id
        assigns(:patron_relationship).should eq(patron_relationship)
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      it "assigns the requested patron_relationship as @patron_relationship" do
        patron_relationship = FactoryGirl.create(:patron_relationship)
        get :edit, :id => patron_relationship.id
        assigns(:patron_relationship).should eq(patron_relationship)
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      it "assigns the requested patron_relationship as @patron_relationship" do
        patron_relationship = FactoryGirl.create(:patron_relationship)
        get :edit, :id => patron_relationship.id
        response.should be_forbidden
      end
    end

    describe "When not logged in" do
      it "should not assign the requested patron_relationship as @patron_relationship" do
        patron_relationship = FactoryGirl.create(:patron_relationship)
        get :edit, :id => patron_relationship.id
        response.should redirect_to(new_user_session_url)
      end
    end
  end

  describe "POST create" do
    before(:each) do
      @attrs = FactoryGirl.attributes_for(:patron_relationship)
      @invalid_attrs = {:parent_id => ''}
    end

    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      describe "with valid params" do
        it "assigns a newly created patron_relationship as @patron_relationship" do
          post :create, :patron_relationship => @attrs
          assigns(:patron_relationship).should be_valid
        end

        it "redirects to the created patron" do
          post :create, :patron_relationship => @attrs
          response.should redirect_to(assigns(:patron_relationship))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved patron_relationship as @patron_relationship" do
          post :create, :patron_relationship => @invalid_attrs
          assigns(:patron_relationship).should_not be_valid
        end

        it "re-renders the 'new' template" do
          post :create, :patron_relationship => @invalid_attrs
          response.should render_template("new")
        end
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      describe "with valid params" do
        it "assigns a newly created patron_relationship as @patron_relationship" do
          post :create, :patron_relationship => @attrs
          assigns(:patron_relationship).should be_valid
        end

        it "redirects to the created patron" do
          post :create, :patron_relationship => @attrs
          response.should redirect_to(assigns(:patron_relationship))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved patron_relationship as @patron_relationship" do
          post :create, :patron_relationship => @invalid_attrs
          assigns(:patron_relationship).should_not be_valid
        end

        it "re-renders the 'new' template" do
          post :create, :patron_relationship => @invalid_attrs
          response.should render_template("new")
        end
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      describe "with valid params" do
        it "assigns a newly created patron_relationship as @patron_relationship" do
          post :create, :patron_relationship => @attrs
          assigns(:patron_relationship).should be_valid
        end

        it "should be forbidden" do
          post :create, :patron_relationship => @attrs
          response.should be_forbidden
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved patron_relationship as @patron_relationship" do
          post :create, :patron_relationship => @invalid_attrs
          assigns(:patron_relationship).should_not be_valid
        end

        it "should be forbidden" do
          post :create, :patron_relationship => @invalid_attrs
          response.should be_forbidden
        end
      end
    end

    describe "When not logged in" do
      describe "with valid params" do
        it "assigns a newly created patron_relationship as @patron_relationship" do
          post :create, :patron_relationship => @attrs
          assigns(:patron_relationship).should be_valid
        end

        it "should be forbidden" do
          post :create, :patron_relationship => @attrs
          response.should redirect_to(new_user_session_url)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved patron_relationship as @patron_relationship" do
          post :create, :patron_relationship => @invalid_attrs
          assigns(:patron_relationship).should_not be_valid
        end

        it "should be forbidden" do
          post :create, :patron_relationship => @invalid_attrs
          response.should redirect_to(new_user_session_url)
        end
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @patron_relationship = FactoryGirl.create(:patron_relationship)
      @attrs = FactoryGirl.attributes_for(:patron_relationship)
      @invalid_attrs = {:parent_id => ''}
    end

    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      describe "with valid params" do
        it "updates the requested patron_relationship" do
          put :update, :id => @patron_relationship.id, :patron_relationship => @attrs
        end

        it "assigns the requested patron_relationship as @patron_relationship" do
          put :update, :id => @patron_relationship.id, :patron_relationship => @attrs
          assigns(:patron_relationship).should eq(@patron_relationship)
          response.should redirect_to(@patron_relationship)
        end

        it "moves its position when specified" do
          put :update, :id => @patron_relationship.id, :patron_relationship => @attrs, :position => 2
          response.should redirect_to(patron_relationships_url)
        end
      end

      describe "with invalid params" do
        it "assigns the requested patron_relationship as @patron_relationship" do
          put :update, :id => @patron_relationship.id, :patron_relationship => @invalid_attrs
          response.should render_template("edit")
        end
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      describe "with valid params" do
        it "updates the requested patron_relationship" do
          put :update, :id => @patron_relationship.id, :patron_relationship => @attrs
        end

        it "assigns the requested patron_relationship as @patron_relationship" do
          put :update, :id => @patron_relationship.id, :patron_relationship => @attrs
          assigns(:patron_relationship).should eq(@patron_relationship)
          response.should redirect_to(@patron_relationship)
        end
      end

      describe "with invalid params" do
        it "assigns the requested patron_relationship as @patron_relationship" do
          put :update, :id => @patron_relationship.id, :patron_relationship => @invalid_attrs
          response.should render_template("edit")
        end
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      describe "with valid params" do
        it "updates the requested patron_relationship" do
          put :update, :id => @patron_relationship.id, :patron_relationship => @attrs
        end

        it "assigns the requested patron_relationship as @patron_relationship" do
          put :update, :id => @patron_relationship.id, :patron_relationship => @attrs
          assigns(:patron_relationship).should eq(@patron_relationship)
          response.should be_forbidden
        end
      end

      describe "with invalid params" do
        it "assigns the requested patron_relationship as @patron_relationship" do
          put :update, :id => @patron_relationship.id, :patron_relationship => @invalid_attrs
          response.should be_forbidden
        end
      end
    end

    describe "When not logged in" do
      describe "with valid params" do
        it "updates the requested patron_relationship" do
          put :update, :id => @patron_relationship.id, :patron_relationship => @attrs
        end

        it "should be forbidden" do
          put :update, :id => @patron_relationship.id, :patron_relationship => @attrs
          response.should redirect_to(new_user_session_url)
        end
      end

      describe "with invalid params" do
        it "assigns the requested patron_relationship as @patron_relationship" do
          put :update, :id => @patron_relationship.id, :patron_relationship => @invalid_attrs
          response.should redirect_to(new_user_session_url)
        end
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @patron_relationship = FactoryGirl.create(:patron_relationship)
    end

    describe "When logged in as Administrator" do
      before(:each) do
        sign_in FactoryGirl.create(:admin)
      end

      it "destroys the requested patron_relationship" do
        delete :destroy, :id => @patron_relationship.id
      end

      it "redirects to the patron_relationships list" do
        delete :destroy, :id => @patron_relationship.id
        response.should redirect_to(patron_relationships_url)
      end
    end

    describe "When logged in as Librarian" do
      before(:each) do
        sign_in FactoryGirl.create(:librarian)
      end

      it "destroys the requested patron_relationship" do
        delete :destroy, :id => @patron_relationship.id
      end

      it "redirects to the patron_relationships list" do
        delete :destroy, :id => @patron_relationship.id
        response.should redirect_to(patron_relationships_url)
      end
    end

    describe "When logged in as User" do
      before(:each) do
        sign_in FactoryGirl.create(:user)
      end

      it "destroys the requested patron_relationship" do
        delete :destroy, :id => @patron_relationship.id
      end

      it "should be forbidden" do
        delete :destroy, :id => @patron_relationship.id
        response.should be_forbidden
      end
    end

    describe "When not logged in" do
      it "destroys the requested patron_relationship" do
        delete :destroy, :id => @patron_relationship.id
      end

      it "should be forbidden" do
        delete :destroy, :id => @patron_relationship.id
        response.should redirect_to(new_user_session_url)
      end
    end
  end
end
