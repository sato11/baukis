require 'rails_helper'

describe StaffMember do
  describe '#password=' do
    example 'hashed_password is a string of 60 characters when given string' do
      member = StaffMember.new
      member.password = 'baukis'
      expect(member.hashed_password).to be_kind_of(String)
      expect(member.hashed_password.size).to eq(60)
    end

    example 'hashed_password is nil when given nil' do
      member = StaffMember.new(hashed_password: nil)
      member.password = nil
      expect(member.hashed_password).to be_nil
    end
  end
end
