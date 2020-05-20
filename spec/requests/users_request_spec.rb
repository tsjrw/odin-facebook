require 'rails_helper'

RSpec.describe "Users", type: :request do
    fixtures :users
    let(:user){ users(:michael) }

    describe "index" do
        it "should redirect when there is not an user logged in" do
            get users_path
            expect(response).to be_redirect
        end
        it "should render successfully whe the user is logged in" do
            sign_in user
            get users_path
            expect(response).to be_successful  
        end
    end

    describe "show" do
        it "should redirect when there is not an user logged in" do
            get user_path(user)
            expect(response).to be_redirect
        end
        it "should render successfully whe the user is logged in" do
            sign_in user
            get user_path(user)
            expect(response).to be_successful
        end
    end
end
