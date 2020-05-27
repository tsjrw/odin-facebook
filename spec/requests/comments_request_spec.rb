require 'rails_helper'

RSpec.describe "Comments", type: :request do
    fixtures :users, :posts, :comments
    let(:logged_user){ users(:michael) }
    let(:unlogged_user){ users(:juan) }
    let(:user_post){ posts(:one) }
    let(:logged_user_comment){ comments(:two) }
    let(:unlogged_user_comment){ comments(:one) }
    let(:valid_params){ { comment: { content: "content" } } }

    def login_user 
        sign_in logged_user
    end

    describe 'create' do
        context 'when not logged' do
            it 'should redirect' do
                expect{ post post_comments_path(user_post.id), params: valid_params }.to change(user_post.comments, :count).by(0)
                expect(response).to have_http_status(:redirect)
            end
        end

        context 'when logged' do
            it 'creates a new comment' do
                login_user
                expect{ post post_comments_path(user_post.id), params: valid_params }.to change(user_post.comments, :count).by(1)
                expect(response).to have_http_status(:redirect)
            end
            it 'creates a comment with the correct attributes' do
                login_user
                post post_comments_path(user_post.id), params: valid_params
                expect(Comment.last).to have_attributes(author_id: logged_user.id, post_id: user_post.id, content:'content')
            end
        end
    end

    describe 'delete' do
        context 'when not logged' do
            it 'should redirect' do
                expect{ delete post_comment_path(user_post.id, logged_user_comment.id) }.to change(user_post.comments, :count).by(0)  
                expect(response).to have_http_status(:redirect)
            end
        end
        context 'when logged' do
            it 'should not delete a comment from another user' do
                login_user
                expect{ delete post_comment_path(user_post.id, unlogged_user_comment.id) }.to change(user_post.comments, :count).by(0)
            end
            it 'should delete a comment from the current user' do
                login_user
                expect{ delete post_comment_path(user_post.id, logged_user_comment.id) }.to change(user_post.comments, :count).by(-1)
            end
        end
    end
            
end
