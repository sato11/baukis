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

  describe 'value normalization' do
    it 'removes spaces around email' do
      member = create(:staff_member, email: ' test@example.com ')
      expect(member.email).to eq 'test@example.com'
    end

    it 'replaces 2-byte-letters with 1-byte' do
      member = create(:staff_member, email: 'ｔｅｓｔ＠ｅｘａｍｐｌｅ．ｃｏｍ')
      expect(member.email).to eq 'test@example.com'
    end

    it 'removes 2-byte-spaces around email' do
      member = create(:staff_member, email: "\u{3000}test@example.com\u{3000}")
      expect(member.email).to eq 'test@example.com'
    end

    it 'replaces hiragana in family_name_kana with katakana' do
      member = create(:staff_member, family_name_kana: 'てすと')
      expect(member.family_name_kana).to eq 'テスト'
    end

    it 'replaces 1-byte-katakana in family_name_kana with 2-byte one' do
      member = create(:staff_member, family_name_kana: 'ﾃｽﾄ')
      expect(member.family_name_kana).to eq 'テスト'
    end
  end

  describe 'validation' do
    it 'is invalid when email includes double @' do
      member = build(:staff_member, email: 'test@@example.com')
      expect(member).not_to be_valid
    end

    it 'is valid when family_name includes kanji' do
      member = build(:staff_member, family_name: '太郎')
      expect(member).to be_valid
    end

    it 'is valid when family_name includes hiragana' do
      member = build(:staff_member, family_name: 'たろう')
      expect(member).to be_valid
    end

    it 'is valid when family_name includes katakana' do
      member = build(:staff_member, family_name: 'タロウ')
      expect(member).to be_valid
    end

    it 'is valid when family_name includes special characters' do
      member = build(:staff_member, family_name: 'タロー')
      expect(member).to be_valid
    end

    it 'is valid when family_name includes alphabet as well as other characters' do
      member = build(:staff_member, family_name: '健たローxx')
      expect(member).to be_valid
    end

    it 'is invalid when family_name_kana includes kanjis' do
      member = build(:staff_member, family_name_kana: '漢字')
      expect(member).not_to be_valid
    end

    it 'is valid when family_name_kana includes special characters' do
      member = build(:staff_member, family_name_kana: 'エリー')
      expect(member).to be_valid
    end

    it 'is invalid when email is already registered' do
      member1 = create(:staff_member)
      member2 = build(:staff_member, email: member1.email)
      expect(member2).not_to be_valid
    end
  end
end
