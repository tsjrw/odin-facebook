User.create(name: "Example", email: "example@mail.com", password: "password", password_confirmation: "password")
User.create(name: "Test", email: "test@mail.com", password: "password", password_confirmation: "password")

10.times do 
    user = User.new
    user.name = Faker::TvShows::ParksAndRec.unique.character
    user.email = Faker::Internet.email(name: user.name, domain:"pawnee")
    user.password = "password"
    user.password_confirmation = "password"
    user.save
end

20.times do
    post = Post.new
    post.author_id = User.pluck(:id).sample
    post.content = Faker::Hipster.sentence
    post.save
end

10.times do
    i = 0
    loop do
        break if User.first.sent_requests.build(user_id: User.pluck(:id).sample).save || i == 50
        i += 1
    end
    i = 0
    loop do
        break if User.first.received_requests.build(friend_id: User.pluck(:id).sample).save || i == 50
        i += 1
    end
end