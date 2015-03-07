class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, presence: true
  has_and_belongs_to_many :gyms, :join_table => :gyms_users
  before_save :set_full_name

  def is_admin?
	  self.admin
	end

	def set_full_name
		self.full_name = "#{first_name} #{last_name}"
	end
end
