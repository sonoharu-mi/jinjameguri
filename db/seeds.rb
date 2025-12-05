# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "seedの実行を開始"

tanaka = User.find_or_create_by!(email: "sample1@test.com") do |user|
  user.name = "あの田中"
  user.password = "tanakadesu"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/test-user1.jpg"), filename:"test-user1.jpg")
end

yamada = User.find_or_create_by!(email: "sample2@test.com") do |user|
  user.name = "だーやま"
  user.password = "yamadadesu"
end

hinata = User.find_or_create_by!(email: "sample3@test.com") do |user|
  user.name = "日向"
  user.password = "hinatadesu"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/ひまわり.jpg"), filename:"ひまわり.jpg")
end

test1 = User.find_or_create_by!(email: "test1@test.com") do |user|
  user.name = "test1"
  user.password = "testtest1"
end

honoka = User.find_or_create_by!(email: "sample4@test.com") do |user|
  user.name = "ほのか"
  user.password = "honokadesu"
end

miyabi = User.find_or_create_by!(email: "sample5@test.com") do |user|
  user.name = "みやび"
  user.password = "miyabidesu"
end

koharu = User.find_or_create_by!(email: "sample6@test.com") do |user|
  user.name = "小春"
  user.password = "koharudesu"
end

post1 = Post.find_or_create_by!(shirine_name: "別府八幡宮") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/八幡宮.jpg"), filename:"八幡宮.jpg")
  post.address = "山口県山陽小野田市有帆１３７７−２"
  post.body = "とても整備されていて雰囲気の良い神社です"
  post.parking = "available"
  post.shirine_stamp = "has_stamp"
  post.seasonal_stamp = "october"
  post.latitude = 34.009960
  post.longitude = 131.170140
  post.user = tanaka
end

post2 = Post.find_or_create_by!(shirine_name: "福徳稲荷神社") do |post|
  post.address = "山口県下関市豊浦町宇賀2960"
  post.body = "境内の写真撮影が禁止でしたので写真はありませんが、とても素晴らしい神社でした。"
  post.parking = "available"
  post.shirine_stamp = "has_stamp"
  post.seasonal_stamp = "regular"
  post.latitude = 34.198167
  post.longitude = 130.935333
  post.user = yamada
end

post3 = Post.find_or_create_by!(shirine_name: "伏見稲荷神社") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/千本鳥居.jpg"), filename:"千本鳥居.jpg")
  post.address = "京都府京都市伏見区深草薮之内町68番地"
  post.body = "千本鳥居がとても魅力的でした"
  post.parking = "available"
  post.shirine_stamp = "has_stamp"
  post.seasonal_stamp = "october"
  post.latitude = 34.967037
  post.longitude = 135.773499
  post.user = hinata
end

post4 = Post.find_or_create_by!(shirine_name: "靖國神社") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/靖国神社.jpg"), filename:"靖国神社.jpg")
  post.address = "東京都千代田区九段北3-1-1"
  post.body = "よく参拝させていただいています"
  post.parking = "available"
  post.shirine_stamp = "has_stamp"
  post.seasonal_stamp = "regular"
  post.latitude = 35.69417
  post.longitude = 139.74278
  post.user = hinata
end

post5 = Post.find_or_create_by!(shirine_name: "神田明神") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/神田明神.jpg"), filename:"神田明神.jpg")
  post.address = "東京都千代田区外神田２丁目１６−２"
  post.body = "日本三大祭りである神田祭を行う神社です。"
  post.parking = "available"
  post.shirine_stamp = "has_stamp"
  post.seasonal_stamp = "october"
  post.latitude = 35.702028
  post.longitude = 139.767889
  post.user = tanaka
end

post6 = Post.find_or_create_by!(shirine_name: "西宮八幡宮") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/西宮八幡宮.jpg"), filename:"西宮八幡宮.jpg")
  post.address = "山口県宇部市上条３丁目９−１５"
  post.body = "西宮"
  post.parking = "available"
  post.shirine_stamp = "has_stamp"
  post.seasonal_stamp = "october"
  post.latitude = 35.702028
  post.longitude = 139.767889
  post.user = tanaka
end

post_comment1 = PostComment.find_or_create_by!(user: tanaka, post: post2) do |comment|
  comment.comment = "すごい気になる🫣\n行ってみたいです！！"
end

post_comment2 = PostComment.find_or_create_by!(user: koharu, post: post1) do |comment|
  comment.comment = "茅の輪初めてみた"
end

group = Group.find_or_create_by!(name: "推し神社を語ろうの会") do |group|
  group.introduction = "今まで参拝した神社の中で特にお気に入りの神社を教えてください。"
  group.owner = tanaka
end

GroupUser.find_or_create_by!(group: group, user: yamada) do |gu|
  gu.status = :approved
end

group2 = Group.find_or_create_by!(name: "御朱印の集い") do |group|
  group.introduction = "オシャンな御朱印教えて〜"
  group.owner = miyabi
end

group2.image.attach(
  io: File.open("#{Rails.root}/db/fixtures/御朱印.jpg"),
  filename: "御朱印.jpg"
) unless group2.image.attached?

Like.find_or_create_by!(user: tanaka, post: post2)
Like.find_or_create_by!(user: tanaka, post: post3)


puts "seedの実行が完了しました"