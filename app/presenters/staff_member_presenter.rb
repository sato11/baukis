class StaffMemberPresenter < ModelPresenter
  delegate :family_name, :given_name, :family_name_kana, :given_name_kana,
           :email, :start_date, :end_date, :suspended?, to: :object

  def full_name
    family_name + ' ' + given_name
  end

  def full_name_kana
    family_name_kana + ' ' + given_name_kana
  end

  # returns a symbol that represents suspended flag
  def suspended_mark
    suspended? ? raw('&#x2611;') : raw('&#x2610;')
  end
end
