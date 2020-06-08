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

User.all.each do |user|
    user.avatar.attach(
        io: open(Faker::LoremFlickr.image(size: "300x300", search_terms: ['people'])),
        filename: "#{user.name.sub(" ", "_")}_avatar",
        content_type: 'image'
    )
end

20.times do
    post = Post.new
    post.author_id = User.pluck(:id).sample
    post.content = Faker::Hipster.sentence
    post.save
end

5.times do
    post = Post.take
    post.photo.attach(
        io: open(Faker::LoremFlickr.image(search_terms: ['cats'])),
        filename: "post_#{post.id}_avatar",
        content_type: 'image'
    )
end


until User.first.sent_requests.count == 3 do
    User.first.sent_requests.build(user_id: User.pluck(:id).sample).save
end

until User.first.received_requests.count == 3 do
    User.first.received_requests.build(friend_id: User.pluck(:id).sample).save
end
