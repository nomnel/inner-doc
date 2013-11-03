require 'spec_helper'

describe ArticlesController do
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
      @article = create(:article)
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
      @article = create(:article, title: 'My title')
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
      article = create(:article)
      get :index
      expect(assigns :articles).to match_array [article]
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

end
