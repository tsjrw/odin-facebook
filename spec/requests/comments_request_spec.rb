require 'rails_helper'

RSpec.describe "Comments", type: :request do
    fixtures :users
    let(:user){ users(:michael) }
    let(:user_post){ user.posts.first }
    let(:valid_params){ { comment: { content: "content" } } }


    describe 'create' do
        context 'when not logged' do
            it 'should not be created' do
                expect{ post post_comments_path(user_post.id), params: valid_params }.to change(user_post.comments, :count).by(0)
                expect(response).to have_http_status(:redirect)
            end
        end
        context 'when logged' do
            it 'creates a new comment' do
                sign_in user
                expect{ post post_comments_path(user_post.id), params: valid_params }.to change(user_post.comments, :count).by(1)
                expect(response).to have_http_status(:redirect)
            end
            it 'creates a comment with the correct attributes' do
                sign_in user
                post post_comments_path(user_post.id), params: valid_params
                expect(Comment.last).to have_attributes(author_id: user.id, post_id: user_post.id, content:'content')
            end
        end
    end
    
end
