class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, presence: true
  has_and_belongs_to_many :gyms, :join_table => :gyms_users
  before_save :set_full_name
  after_create :send_admin_mail

  def is_admin?
	  self.admin
	end

  def is_approved?
    self.approved
  end

  def is_paid?
    (self.paid_date.to_date > 1.month.ago) || (self.sessions_remaining > 0)
  end

	def set_full_name
		self.full_name = "#{first_name} #{last_name}"
	end

  def active_for_authentication? 
    super && is_approved?
  end 

  def inactive_message 
    if !is_approved? 
      :not_approved 
    else 
      super
    end
  end

  def send_admin_mail
    AdminMailer.new_user_waiting_for_approval(self).deliver
  end
end
