class Post < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :shirine_name, presence: true
  validates :address, presence: true
  validates :body, presence: true, length: {maximum: 500}
  validates :parking, inclusion: {in: ['unavailable','available']}
  validates :shirine_stamp, inclusion: {in: ['no_stamp','has_stamp']}
  validates :seasonal_stamp, inclusion: {in:['regular', 'january', 'february', 'march', 'april', 'may', 'june', 'july', 'august', 'september', 'october', 'november', 'december', 'nostamp']}

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/No_神社image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def self.search_for(content, method)
    if method == "perfect"
      Post.where(shirine_name: content)
    elsif method == 'forward'
      Post.where('shirine_name LIKE ?', content+'%')
    elsif method == 'backward'
      Post.where('shirine_name LIKE ?', '%'+content)
    else
      Post.where('shirine_name LIKE ?', '%'+content+'%')
    end
  end


  def favorited_by?(user)
    likes.exists?(user_id: user.id)
  end

  enum parking: { unavailable: 0, available: 1}
  enum shirine_stamp: { no_stamp: 0, has_stamp: 1}
  enum seasonal_stamp: {regular: 0, january: 1, february: 2, march: 3, april: 4, may: 5, june: 6, july: 7, august: 8, september: 9, october: 10, november: 11, december: 12, nostamp: 13}

  
end
