class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_and_belongs_to_many :courses, -> { uniq }
  has_many :posts
  has_many :favorite_posts
  has_many :favorites, through: :favorite_posts, source: :course #department?

end
