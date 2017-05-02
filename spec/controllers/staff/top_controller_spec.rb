require 'spec_helper'

describe Staff::TopController do
  let(:staff_member) { create(:staff_member) }

  context 'after logging in' do
    before do
      session[:staff_member_id] = staff_member.id
      session[:last_access_at] = 1.seconds.ago
    end

    describe '#index' do
      it 'renders staff/top/dashboard' do
        get :index
        expect(response).to render_template 'staff/top/dashboard'
      end

      it 'forces logout when suspended flag is set' do
        staff_member.update_column(:suspended, true)
        get :index
        expect(session[:staff_member_id]).to be_nil
        expect(response).to redirect_to :staff_root
      end

      example 'session timeout' do
        session[:last_access_at] = Staff::Base::TIMEOUT.ago.advance(seconds: -1)
        get :index
        expect(session[:staff_member_id]).to be_nil
        expect(response).to redirect_to :staff_login
      end
    end
  end
end
