class Staff::Base < ApplicationController
  before_action :authenticate_staff_member
  before_action :check_account, :check_timeout

  private

  def current_staff_member
    if session[:staff_member_id]
      @current_staff_member ||= StaffMember.find_by(id: session[:staff_member_id])
    end
  end

  helper_method :current_staff_member

  def authenticate_staff_member
    unless current_staff_member
      flash.alert = '職員としてログインしてください'
      redirect_to :staff_login and return
    end
  end

  def check_account
    if current_staff_member && !current_staff_member.active?
      session.delete(:staff_member_id)
      flash.alert = 'アカウントが無効になりました'
      redirect_to :staff_root
    end
  end

  TIMEOUT = 60.minutes

  def check_timeout
    if current_staff_member
      # update last_access_at if the access is within session duration
      if TIMEOUT.ago <= session[:last_access_at]
        session[:last_access_at] = Time.current
      else
        session.delete(:staff_member_id)
        flash.alert = 'セッションがタイムアウトしました'
        redirect_to :staff_login
      end
    end
  end
end
