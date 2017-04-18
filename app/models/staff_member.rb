class StaffMember < ActiveRecord::Base
  has_many :events, class_name: 'StaffEvent', dependent: :destroy

  before_validation do
    # PostgreSQL doesn't recognize the difference of up/downcase.
    # Having unique restriction as well as index option,
    # email_for_index column takes care of this matter.
    self.email_for_index = email.downcase if email
  end

  def password=(raw_password)
    if raw_password.is_a?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end

  def active?
    !suspended? &&
    start_date <= Date.today &&
    (end_date.nil? || Date.today < end_date)
  end

  def full_name
    family_name + given_name
  end
end
