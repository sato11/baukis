require 'rails_helper'

describe Administrator do
  describe '#password=' do
    example 'hashed_password is a string of 60 characters when given string' do
      administrator = Administrator.new
      administrator.password = 'baukis'
      expect(administrator.hashed_password).to be_kind_of(String)
      expect(administrator.hashed_password.size).to eq(60)
    end

    example 'hashed_password is nil when given nil' do
      administrator = Administrator.new(hashed_password: nil)
      administrator.password = nil
      expect(administrator.hashed_password).to be_nil
    end
  end
end
