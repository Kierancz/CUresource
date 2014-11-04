class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_and_belongs_to_many :courses, -> { uniq }
  has_many :posts
  has_many :favorites
  has_many :favorite_courses, through: :favorites, source: :favoritable, source_type: 'Course'
  has_many :favorite_posts, through: :favorites, source: :favoritable, source_type: 'Post'

  ROLES = %w[admin instructor]

end
