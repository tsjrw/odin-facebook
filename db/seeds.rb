User.create(name: "Example", email: "example@mail.com", password: "password", password_confirmation: "password")

5.times do 
    user = User.new
    user.name =  Faker::TvShows::ParksAndRec.unique.character
    user.email = Faker::Internet.email(name: user.name, domain:"pawnee")
    user.password = "password"
    user.password_confirmation = "password"
    user.save
end

8.times do
    post = Post.new
    post.author_id = User.pluck(:id).sample
    post.content = Faker::Hipster.sentence
    post.save
end