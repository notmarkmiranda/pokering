require 'rails_helper'

describe HomeController, type: :controller do
  context 'GET#index' do
    it 'renders index template' do
      get :index

      expect(response).to render_template :index
    end
  end

end
