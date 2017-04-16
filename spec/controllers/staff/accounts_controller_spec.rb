require 'rails_helper'

describe Staff::AccountsController do
  context 'before logging in' do
    it_behaves_like 'a protected singular staff controller'
  end

  context 'after logging in' do
    describe '#update' do
      let(:params_hash) { attributes_for(:staff_member) }
      let(:staff_member) { create(:staff_member) }

      before do
        session[:staff_member_id] = staff_member.id
        session[:last_access_at] = 1.seconds.ago
      end

      it 'updates email attribute' do
        params_hash.merge!(email: 'test@example.com')
        patch :update, id: staff_member.id, staff_member: params_hash
        staff_member.reload
        expect(staff_member.email).to eq 'test@example.com'
      end

      it 'raises ActionController::ParameterMissing when withou' do
        bypass_rescue
        expect do
          patch :update, id: staff_member.id
        end.to raise_error ActionController::ParameterMissing
      end

      it 'is not permitted to change end_date' do
        params_hash.merge!(end_date: Date.tomorrow)
        expect do
          patch :update, id: staff_member.id, staff_member: params_hash
        end.not_to change { staff_member.end_date }
      end
    end
  end
end
