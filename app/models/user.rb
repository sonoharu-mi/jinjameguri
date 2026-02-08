class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:name]

  validates :name, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy 
  has_many :groups, through: :group_users
  has_many :owned_groups, class_name: 'Group', foreign_key: 'owner_id', dependent: :destroy
  has_many :calendars, dependent: :destroy

  has_one_attached :profile_image

  def get_profile_image(width,height)
    if profile_image.attached?
      begin
        profile_image.variant(resize_to_limit: [width, height]).processed
      rescue
        'no_image.jpg'
      end
    else
      'no_image.jpg'
    end
  end

  def self.search_for(content, method)
    if method == "perfect"
      where(name: content)
    else
      where("name LIKE ?", "%#{content}%")
    end
  end
  
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "おためし"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end
end
