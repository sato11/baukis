shared_examples 'a protected admin controller' do
  describe '#index' do
    it 'redirects to login form' do
      get :index
      expect(response).to redirect_to :admin_login
    end
  end

  describe '#show' do
    it 'redirects to login form' do
      get :show, id: 1
      expect(response).to redirect_to :admin_login
    end
  end
end

shared_examples 'a protected singular admin controller' do
  describe '#show' do
    it 'redirects to login form' do
      get :index
      expect(response).to redirect_to :admin_login
    end
  end
end
