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
    if auto_pay?
      is_paid = true
    else
      if self.paid_date
        if self.paid_date.to_date > 1.month.ago
          is_paid = true
        elsif self.sessions_remaining > 0
          is_paid = true
          @sessions = self.sessions_remaining - 1
          self.update_attributes(sessions_remaining: @sessions)
          if self.sessions_remaining == 1
            UserNotifier.send_sessions_email(self).deliver_now
          end
        end
      elsif self.sessions_remaining > 0
        is_paid = true
        @sessions = self.sessions_remaining - 1
        self.update_attributes(sessions_remaining: @sessions)
        if self.sessions_remaining == 1
          UserNotifier.send_sessions_email(self).deliver_now
        end
      end
    end
    is_paid
  end

  def is_paid?
    is_paid = false
    if auto_pay?
      is_paid = true
    else
      if self.paid_date
        if self.paid_date.to_date > 1.month.ago
          is_paid = true
        elsif self.sessions_remaining > 0
          is_paid = true
        end
      elsif self.sessions_remaining > 0
        is_paid = true
      end
    end
    is_paid
  end

  def receives_notifications?
    self.notifications
  end

  def has_cell_phone_number?
    has_number = false
    if self.cell_phone_number.to_i > 0
      has_number = true
    end
    has_number
  end
  
  def cell_number
    self.cell_phone_number
  end

  def auto_pay?
    self.auto_pay
  end

	def adjust_user
    self.first_name = self.first_name.slice(0,1).capitalize + self.first_name.slice(1..-1)
    self.last_name = self.last_name.slice(0,1).capitalize + self.last_name.slice(1..-1)
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
