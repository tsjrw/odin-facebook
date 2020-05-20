require 'rails_helper'

RSpec.describe "Posts", type: :request do
fixtures :users
let(:user){ users(:michael) }
let(:valid_params){ { post: { content:"content" } } }

    context 'showing posts' do
        it 'should not show posts to unlogged users' do
            get posts_path
            expect(response).to be_redirect
            get post_path(user.posts.first)
            expect(response).to be_redirect
        end
        it 'should show posts when an users is logged' do
            sign_in user
            get posts_path
            expect(response).to be_successful
            get post_path(user.posts.first)
            expect(response).to be_successful
        end
    end

    context 'creating posts' do 
        it 'should not create a post when an user is not logged' do
            expect{ post posts_path, params: valid_params }.to change{Post.count}.by(0)
            expect(response).to have_http_status(:redirect)
        end
        it 'should create a post if an user is logged' do
            sign_in user
            expect{ post posts_path, params: valid_params }.to change{Post.count}.by(1)
            expect(response).to have_http_status(:redirect)
        end
    end

end
