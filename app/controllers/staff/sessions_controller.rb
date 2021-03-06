class Staff::SessionsController < Staff::Base
  skip_before_action :authenticate_staff_member

  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: 'new' # necessary?
    end
  end

  def create
    @form = Staff::LoginForm.new(params[:staff_login_form])
    if @form.email.present?
      staff_member = StaffMember.find_by(email_for_index: @form.email.downcase)
      if staff_member.suspended
        staff_member.events.create!(type: 'rejected')
        flash.now.alert = 'アカウントが停止されています'
        render action: 'new' and return
      end
    end
    if Staff::Authenticator.new(staff_member).authenticate(@form.password)
      session[:staff_member_id] = staff_member.id
      session[:last_access_at] = Time.current
      staff_member.events.create!(type: 'logged_in')
      flash.notice = 'ログインしました'
      redirect_to :staff_root
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません'
      render action: 'new'
    end
  end

  def destroy
    current_staff_member.events.create!(type: 'logged_out') if current_staff_member
    session.delete(:staff_member_id)
    flash.notice = 'ログアウトしました'
    redirect_to :staff_root
  end
end
