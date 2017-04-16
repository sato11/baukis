require 'rails_helper'

describe Admin::StaffMembersController do
  let(:params_hash) { attributes_for(:staff_member) }
  let(:administrator) { create(:administrator) }

  context 'before logging in' do
    it_behaves_like 'a protected admin controller'
  end

  context 'after logging in' do
    before do
      session[:administrator_id] = administrator.id
      session[:last_access_at] = 1.seconds.ago
    end

    describe '#create' do
      it 'redirects to the list of staff members' do
        post :create, staff_member: params_hash
        expect(response).to redirect_to :admin_staff_members
      end

      it 'raises ActionController::ParameterMissing when without params' do
        bypass_rescue
        expect{ post :create }.to raise_error ActionController::ParameterMissing
      end
    end

    describe '#update' do
      let(:staff_member) { create(:staff_member) }

      it 'sets suspended flag' do
        params_hash.merge!(suspended: true)
        patch :update, id: staff_member.id, staff_member: params_hash
        staff_member.reload
        expect(staff_member).to be_suspended
      end

      example 'hashed_password is not writab;e' do
        params_hash.delete(:password)
        params_hash.merge!(hashed_password: 'x')
        expect do
          patch :update, id: staff_member.id, staff_member: params_hash
        end.not_to change { staff_member.hashed_password.to_s }
      end
    end
  end
end
