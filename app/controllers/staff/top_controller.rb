class Staff::TopController < Staff::Base
  skip_before_action :authenticate_staff_member

  def index
    if current_staff_member
      render action: 'dashboard'
    else
      render action: 'index'
    end
  end
end
