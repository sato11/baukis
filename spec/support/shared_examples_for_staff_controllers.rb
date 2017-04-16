shared_examples 'a protected staff controller' do
  describe '#index' do
    it 'redirects to staff login form' do
      get :index
      expect(response).to redirect_to :staff_login
    end
  end

  describe '#show' do
    it 'redirects to staff login form' do
      get :show, id: 1
      expect(response).to redirect_to :staff_login
    end
  end
end

shared_examples 'a protected singular staff controller' do
  describe '#show' do
    it 'redirects to staff login form' do
      get :show
      expect(response).to redirect_to :staff_login
    end
  end
end
