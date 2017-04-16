class Staff::TopController < Staff::Base
  skip_before_action :authenticate_staff_member
  def index
  end
end
