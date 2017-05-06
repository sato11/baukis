class WorkAddress < Address
  before_validation do
    company_name = normalize_as_name(company_name)
    division_name = normalize_as_name(division_name)
  end

  validates :company_name, presence: true
end
