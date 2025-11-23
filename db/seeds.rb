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

Post.find_or_create_by!(shirine_name: "別府八幡宮") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/八幡宮.jpg"), filename:"八幡宮.jpg")
  post.address = "山口県山陽小野田市有帆１３７７−２"
  post.body = "とても整備されていて雰囲気の良い神社です"
  post.parking = "available"
  post.shirine_stamp = "has_stamp"
  post.seasonal_stamp = "october"
  post.user = tanaka
end

Post.find_or_create_by!(shirine_name: "福徳稲荷神社") do |post|
  post.address = "山口県下関市豊浦町宇賀2960"
  post.body = "境内の写真撮影が禁止でしたので写真はありませんが、とても素晴らしい神社でした。"
  post.parking = "available"
  post.shirine_stamp = "has_stamp"
  post.seasonal_stamp = "regular"
  post.user = yamada
end

Post.find_or_create_by!(shirine_name: "伏見稲荷神社") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/千本鳥居.jpg"), filename:"千本鳥居.jpg")
  post.address = "京都府京都市伏見区深草薮之内町68番地"
  post.body = "千本鳥居がとても魅力的でした"
  post.parking = "available"
  post.shirine_stamp = "has_stamp"
  post.seasonal_stamp = "october"
  post.user = hinata
end

Post.find_or_create_by!(shirine_name: "靖國神社") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/靖国神社.jpg"), filename:"靖国神社.jpg")
  post.address = "東京都千代田区九段北3-1-1"
  post.body = "よく参拝させていただいています"
  post.parking = "available"
  post.shirine_stamp = "has_stamp"
  post.seasonal_stamp = "regular"
  post.user = hinata
end

group = Group.find_or_create_by!(name: "推し神社を語ろうの会") do |group|
  group.introduction = "今まで参拝した神社の中で特にお気に入りの神社を教えてください。"
  group.owner = tanaka
end

group.users << yamada unless group.users.include?(yamada)

puts "seedの実行が完了しました"