require 'rails_helper'

RSpec.describe "LikeRelationships", type: :request do
    fixtures :users, :posts
    let(:user_1){users(:michael)}
    let(:user_2){users(:juan)}
    let(:user_post){posts(:two)}
    let(:referrer){ {'HTTP_REFERER' => "/"} }

    def user_likes_post
        sign_in user_2
        post post_likes_path(user_post.id), headers: referrer
        sign_out user_2
    end

    describe 'liking post' do
        context "when not logged" do
            it 'should redirect' do 
                expect{ post post_likes_path(user_post.id), headers: referrer }.to change(user_post.users_liking, :count).by(0)
                expect(response).to have_http_status(:redirect)
            end
        end
        context 'when logged' do
            it 'increase the number of likes of the post' do
                sign_in user_1
                expect{ post post_likes_path(user_post.id), headers: referrer }.to change(user_post.users_liking, :count).by(1)
            end
            it 'should not increase the number if the user already like the same post' do
                sign_in user_1
                post post_likes_path(user_post.id), headers: referrer 
                expect{ post post_likes_path(user_post.id), headers: referrer }.to change(user_post.users_liking, :count).by(0)
            end
            it 'should not increase the number of likes of another user' do
                sign_in user_1
                expect{ post post_likes_path(user_post.id), headers: referrer }.to change(user_2.liked_posts, :count).by(0)
            end
        end
        
    end

    describe 'unlike' do
        context 'when not logged' do
            it 'should not decrease the number of likes' do
                user_likes_post
                expect{ delete post_unlike_path(user_post.id), headers: referrer }.to change(user_post.users_liking, :count).by(0)
            end
        end
        context 'when logged' do
            it 'should not decrease the number of likes of another user' do
                user_likes_post
                sign_in user_1
                expect{ delete post_unlike_path(user_post.id), headers: referrer }.to change(user_2.liked_posts, :count).by(0)
            end
            it 'should not do anything if the user does not already like the post' do
                sign_in user_1
                expect{ delete post_unlike_path(user_post.id), headers: referrer }.to change(user_post.users_liking, :count).by(0)
            end
            it 'should decrease the number of likes of the current user' do
                sign_in user_1
                post post_likes_path(user_post.id), headers: referrer 
                expect{ delete post_unlike_path(user_post.id), headers: referrer }.to change(user_1.liked_posts, :count).by(-1)
            end
        end
    end
end
