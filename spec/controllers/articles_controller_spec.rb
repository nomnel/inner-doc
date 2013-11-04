require 'spec_helper'

describe ArticlesController do
  describe "user access" do
    before :each do
      @user = create(:user)
      set_user_session @user
    end

    describe 'GET #new' do
      it "assigns a new Article to @article" do
        get :new
        expect(assigns :article).to be_a_new Article
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      context "with valid attributes" do
        it "saves the new article in the database" do
          expect{
            post :create, article: attributes_for(:article)
          }.to change(Article, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not saves the new article in the database" do
          expect{
            post :create, article: attributes_for(:invalid_article)
          }.to_not change(Article, :count)
        end

        it "re-renders the :new template" do
          post :create, article: attributes_for(:invalid_article)
          expect(response).to render_template :new
        end
      end
    end

    describe 'GET #edit' do
      before :each do
        @article = article_editable_by_user create(:article), @user
      end

      it "assigns the requested article to @article" do
        get :edit, id: @article
        expect(assigns :article).to eq @article
      end

      it "renders the :edit template" do
        get :edit, id: @article
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      before :each do
        @article = article_editable_by_user create(:article, title: 'My title'), @user
      end

      context "with valid attributes" do
        it "changes @article's attributes" do
          new_title = 'Our title'
          patch :update, id: @article,
                         article: attributes_for(:article, title: new_title)
          @article.reload
          expect(@article.title).to eq new_title
        end
      end

      context "with invalid attributes" do
        it "does not change the article's attributes" do
          patch :update, id: @article,
                         article: attributes_for(:article, title: nil)
          @article.reload
          expect(@article.title).to_not eq nil
        end

        it "re-renders the :edit template" do
          patch :update, id: @article,
                         article: attributes_for(:invalid_article)
          expect(response).to render_template :edit
        end
      end
    end

    describe 'GET #index' do
      it "collects articles into @articles" do
        article = article_editable_by_user create(:article), @user
        get :index
        expect(assigns :articles).to match_array [article]
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'DELETE #destroy' do
      before :each do
        @article = article_editable_by_user create(:article), @user
      end

      it "doesn't deletes the article" do
        expect{
          delete :destroy, id: @article
        }.to_not change(Article, :count)
      end

      it "redirects to articles#index" do
        delete :destroy, id: @article
        expect(response).to redirect_to articles_url
      end
    end
  end

  describe "admin access" do
    describe 'DELETE #destroy' do
      before :each do
        @user = create(:admin)
        set_user_session @user
        @article = article_editable_by_user create(:article), @user
      end

      it "deletes the article" do
        expect{
          delete :destroy, id: @article
        }.to change(Article, :count).by(-1)
      end

      it "redirects to articles#index" do
        delete :destroy, id: @article
        expect(response).to redirect_to articles_url
      end
    end
  end

  describe "guest access" do
    describe 'GET #index' do
      it "requires login" do
        get :index
        expect(response).to require_login
      end
    end

    describe 'GET #new' do
      it "requires login" do
        get :new
        expect(response).to require_login
      end
    end

    describe 'GET #edit' do
      it "requires login" do
        article = create(:article)
        get :edit, id: article
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it "requires login" do
        post :create, article: build(:article)
        expect(response).to require_login
      end
    end

    describe 'PATCH #update' do
      it "requires login" do
        article = create(:article)
        patch :update, id: article
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it "requires login" do
        article = create(:article)
        delete :destroy, id: article
        expect(response).to require_login
      end
    end
  end
end
