require 'spec_helper'

feature 'phone number management by staff' do
  include FeaturesSpecHelper
  let(:staff_member) { create(:staff_member) }
  let!(:customer) { create(:customer) }

  before do
    switch_namespace(:staff)
    login_as_staff_member(staff_member)
  end

  scenario "staff adds customer's phone number" do
    click_link '顧客管理'
    first('table.listing').click_link '編集'

    fill_in 'form_customer_phones_0_number', with: '090-9999-9999'
    check 'form_customer_phones_0_primary'
    click_button '更新'

    customer.reload
    expect(customer.personal_phones.size).to eq(1)
    expect(customer.personal_phones[0].number).to eq('090-9999-9999')
  end

  scenario "staff adds customer's home number" do
    click_link '顧客管理'
    first('table.listing').click_link '編集'

    fill_in 'form_home_address_phones_0_number', with: '03-9999-9999'
    check 'form_home_address_phones_0_primary'
    click_button '更新'

    customer.reload
    expect(customer.home_address.phones.size).to eq(1)
    expect(customer.home_address.phones[0].number).to eq('03-9999-9999')
  end

  scenario "staff adds customer's work number" do
    click_link '顧客管理'
    first('table.listing').click_link '編集'

    fill_in 'form_work_address_phones_0_number', with: '03-3333-3333'
    check 'form_work_address_phones_0_primary'
    click_button '更新'

    customer.reload
    expect(customer.work_address.phones.size).to eq(1)
    expect(customer.work_address.phones[0].number).to eq('03-3333-3333')
  end
end
