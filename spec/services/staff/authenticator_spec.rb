require 'spec_helper'

describe Staff::Authenticator do
  describe '#authenticate' do
    it 'returns true if password matches' do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_truthy
    end

    it 'returns false if password does not match' do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate('aa')).to be_falsey
    end

    it 'returns false if password is not set' do
      m = build(:staff_member, password: nil)
      expect(Staff::Authenticator.new(m).authenticate(nil)).to be_falsey
    end

    it 'returns false if the account is suspended' do
      m = build(:staff_member, suspended: true)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end

    it 'returns false if the account is not started' do
      m = build(:staff_member, start_date: Date.tomorrow)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end

    it 'returns false if the account is ended' do
      m = build(:staff_member, end_date: Date.today)
      expect(Staff::Authenticator.new(m).authenticate('pw')).to be_falsey
    end
  end
end
