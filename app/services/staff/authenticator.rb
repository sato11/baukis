class Staff::Authenticator
  def initialize(staff_member)
    @staff_member = staff_member
  end

  def authenticate(raw_password)
    @staff_member &&
      !@staff_member.suspended &&
      @staff_member.hashed_password &&
      @staff_member.start_date <= Date.today &&
      (@staff_member.end_date.nil? || Date.today < @staff_member.end_date) &&
      BCrypt::Password.new(@staff_member.hashed_password) == raw_password
  end
end
