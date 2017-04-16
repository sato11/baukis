require 'rails_helper'

describe Admin::TopController do
  describe '#index' do
    context 'befor logging in' do
      it 'renders admin/topindex' do
        get :index
        expect(response).to render_template 'admin/top/index'
      end
    end

    context 'after logging in' do
      let(:administrator) { create(:administrator) }

      before do
        session[:administrator_id] = administrator.id
        session[:last_access_at] = 1.seconds.ago
      end

      it 'renders admin/top/index' do
        get :index
        expect(response).to render_template 'admin/top/dashboard'
      end

      it 'forces logout when suspended flag is set' do
        administrator.update_column(:suspended, true)
        get :index
        expect(session[:administrator_id]).to be_nil
        expect(response).to redirect_to :admin_root
      end

      example 'session timeout' do
        session[:last_access_at] = Admin::Base::TIMEOUT.ago.advance(seconds: -1)
        get :index
        expect(session[:administrator_id]).to be_nil
        expect(response).to redirect_to :admin_login
      end
    end
  end
end
