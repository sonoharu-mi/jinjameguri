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

Post.find_or_create_by!(shirine_name: "○○八幡宮") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/八幡宮.jpg"), filename:"八幡宮.jpg")
  post.address = "大分県ああ市いい町１２３"
  post.body = "とても整備されていて雰囲気の良い神社です"
  post.parking = "available"
  post.shirine_stamp = "has_stamp"
  post.seasonal_stamp = "october"
  post.user = tanaka
end

Post.find_or_create_by!(shirine_name: "△△稲荷神社") do |post|
  post.address = "山口県ええ市おお町４５６"
  post.body = "境内の写真撮影が禁止でしたので写真はありませんが、とても素晴らしい神社でした。"
  post.parking = "available"
  post.shirine_stamp = "has_stamp"
  post.seasonal_stamp = "regular"
  post.user = yamada
end

puts "seedの実行が完了しました"