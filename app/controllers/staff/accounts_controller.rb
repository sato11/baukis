class Staff::AccountsController < Staff::Base
  before_action :set_staff_member

  def show; end

  def edit; end

  def update
    if @staff_member.update(staff_member_params)
      flash.notice = 'アカウント情報を更新しました'
      redirect_to :staff_account
    else
      render action: 'edit'
    end
  end

  private

  def set_staff_member
    @staff_member = current_staff_member
  end

  def staff_member_params
    params.require(:staff_member).permit(
      :email, :family_name, :given_name,
      :family_name_kana, :given_name_kana
    )
  end
end
