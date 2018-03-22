require 'rails_helper'

describe LeaguesController, type: :controller do
  let(:user) { create(:user) }
  let(:league) { create(:league, creator: user) }


  context 'GET#show' do
    let(:league) { create(:league) }

    it 'renders show template' do
      get :show, params: { id: league.id }

      expect(response).to render_template :show
    end
  end

  context 'needs login' do
    before do
      sign_in(user)
    end

    context 'GET#index' do
      it 'renders index template' do
        get :index

        expect(response).to render_template :index
      end
    end

    context 'GET#new' do
      it 'renders new template' do
        get :new

        expect(response).to render_template :new
      end
    end

    context 'GET#edit' do
      it 'renders edit template' do
        get :edit, params: { id: league.id }

        expect(response).to render_template :edit
      end
    end

    context 'POST#create' do
      let(:attrs) { attributes_for(:league) }

      it 'redirects to league show path - successful create' do
        post :create, params: { league: attrs }

        expect(response).to redirect_to League.last
      end

      it 'renders new template - unsuccessful create' do
        post :create, params: { league: { name: '' } }

        expect(response).to render_template :new
      end
    end

    context 'PATCH#update' do
      it 'redirects to league show path - successful update' do
        patch :update, params: { id: league.id, league: { name: 'New League Name' } }

        expect(response).to redirect_to league.reload
      end

      it 'renders edit template' do
        patch :update, params: { id: league.id, league: { name: '' } }

        expect(response).to render_template :edit
      end
    end

    context 'DELETE#destroy' do
      it 'redirects to league index path' do
        delete :destroy, params: { id: league.id }

        expect(response).to redirect_to leagues_path
      end
    end
  end

end
