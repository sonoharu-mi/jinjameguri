class Post < ApplicationRecord

  has_one_attached :image
  belongs_to :user

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/No_神社image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  enum parking: { unavailable: 0, available: 1}
  enum shirine_stamp: { no_stamp: 0, has_stamp: 1}
  enum seasonal_stamp: {regular: 0, january: 1, february: 2, march: 3, april: 4, may: 5, june: 6, july: 7, august: 8, september: 9, october: 10, november: 11, december: 12, nostamp: 13}

  validates :shirine_name, presence: true
  validates :address, presence: true
  validates :body, presence: true, length: {maximum: 500}
  validates :parking, inclusion: {in: ['駐車場無し','駐車場有り']}
  validates :shirine_stamp, inclusion: {in: ['御朱印無し','御朱印有り']}
  validates :seasonal_stamp, inclusion: {in:['通常','1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月','無し']}
end
