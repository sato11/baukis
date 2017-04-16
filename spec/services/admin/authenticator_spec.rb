require 'spec_helper'

describe Admin::Authenticator do
  describe '#authenticate' do
    it 'returns true if password matches' do
      admin = build(:administrator)
      expect(Admin::Authenticator.new(admin).authenticate('pw')).to be_truthy
    end

    it 'returns false if password does not match' do
      admin = build(:administrator)
      expect(Admin::Authenticator.new(admin).authenticate('aa')).to be_falsey
    end

    it 'returns false if password is not set' do
      admin = build(:administrator, password: nil)
      expect(Admin::Authenticator.new(admin).authenticate(nil)).to be_falsey
    end

    it 'returns false if the account is suspended' do
      admin = build(:administrator, suspended: true)
      expect(Admin::Authenticator.new(admin).authenticate('pw')).to be_falsey
    end
  end
end
