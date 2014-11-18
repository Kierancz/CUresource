class Department < ActiveRecord::Base
	has_many :courses, inverse_of: :department
	has_many :posts, as: :postable	#allows polymorphic posts
	has_and_belongs_to_many :users, -> {uniq}

	scope :alph, lambda { order("departments.subject ASC") }
end
