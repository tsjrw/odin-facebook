require 'rails_helper'

RSpec.describe "Posts", type: :request do
fixtures :users
let(:logged_user){ users(:michael) }
let(:unlogged_user){ users(:juan) }
let(:logged_user_post){ logged_user.posts.first }
let(:unlogged_user_post){ unlogged_user.posts.first }
let(:valid_params){ { post: { content:"content" } } }

def log_in_user
    sign_in logged_user
end

    context 'create' do 
        context 'when not logged' do
            it 'should redirect' do
                expect{ post posts_path, params: valid_params }.to change(Post, :count).by(0)
                expect(response).to have_http_status(:redirect)
            end
        end
        context 'when logged' do
            it 'should create a post for the current user' do
                log_in_user
                expect{ post posts_path, params: valid_params }.to change(logged_user.posts, :count).by(1)
            end
        end
    end

    context 'delete' do 
        context 'when not logged' do
            it 'should redirect' do
                expect{ delete post_path(logged_user_post.id) }.to change(logged_user.posts, :count).by(0)
                expect(response).to have_http_status(:redirect)
            end
        end
        context 'when logged' do
            it 'should not delete a post from another user' do
                log_in_user
                expect{ delete post_path(unlogged_user_post.id) }.to change(unlogged_user.posts, :count).by(0)
            end
            it 'should delete a post from the current user' do
                log_in_user
                expect{ delete post_path(logged_user_post.id) }.to change(logged_user.posts, :count).by(-1)
            end
        end
    end

end
