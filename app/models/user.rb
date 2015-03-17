class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :first_name, :last_name, :email, presence: true

  has_and_belongs_to_many :gyms
  has_many :logins, dependent: :destroy
  accepts_nested_attributes_for :gyms, allow_destroy: true
  
  before_save :adjust_user
  after_create :send_signup_email

  def is_admin?
	  self.admin
	end

  def is_approved?
    self.approved
  end

  def is_paid_at_login?
    is_paid = false
    if self.paid_date
      if self.paid_date.to_date > 1.month.ago
        is_paid = true
      elsif self.sessions_remaining > 0
        @sessions = self.sessions_remaining - 1
        self.update_attributes(sessions_remaining: @sessions)
        is_paid = true
      end
    elsif self.sessions_remaining > 0
      is_paid = true
      @sessions = self.sessions_remaining - 1
      self.update_attributes(sessions_remaining: @sessions)
    end
    is_paid
  end

  def is_paid?
    if self.paid_date
      (self.paid_date.to_date > 1.month.ago) || (self.sessions_remaining > 0)
    else
      self.sessions_remaining > 0
    end
  end

	def adjust_user
		self.first_name = self.first_name.titleize
    self.last_name = self.last_name.titleize
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

  def agreed_to_waiver?
    self.agreed_to_waiver
  end

  def send_signup_email
    UserNotifier.send_signup_email(self).deliver_now
    UserNotifier.send_user_waiting_for_approval_email(self).deliver_now
  end
end
