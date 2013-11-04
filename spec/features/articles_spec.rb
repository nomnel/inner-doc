require 'spec_helper'

feature 'Create article' do
  background do
    sign_in
    @article = build(:article)
  end

  scenario 'successfully' do
    visit new_article_path

    p = 'helpers.label.article'
    expect{
      fill_in I18n.t("#{p}.title"),   with: @article.title
      fill_in I18n.t("#{p}.content"), with: @article.content
      click_button I18n.t('helpers.submit.create')
    }.to change(Article, :count).by(1)

    expect(current_path).to eq articles_path
    expect(page).to have_content I18n.t('article_was_successfully_created')
  end

  scenario 'failed' do
    visit new_article_path

    p = 'helpers.label.article'
    expect{
      fill_in I18n.t("#{p}.title"),   with: nil
      fill_in I18n.t("#{p}.content"), with: @article.content
      click_button I18n.t('helpers.submit.create')
    }.to_not change(Article, :count)
  end
end

feature 'Update article' do
  background do
    user = sign_in
    @article = article_editable_by_user create(:article), user
  end

  scenario 'successfully' do
    visit edit_article_path(@article)

    p = 'helpers.label.article'
    new_title = 'My Title'
    fill_in I18n.t("#{p}.title"),   with: new_title
    fill_in I18n.t("#{p}.content"), with: @article.content
    click_button I18n.t('helpers.submit.update')

    expect(find_link(new_title).visible?).to eq true
    expect(current_path).to eq articles_path
    expect(page).to have_content I18n.t('article_was_successfully_updated')
  end

  scenario 'failed' do
    visit edit_article_path(@article)

    p = 'helpers.label.article'
    new_title = ''
    fill_in I18n.t("#{p}.title"),   with: new_title
    fill_in I18n.t("#{p}.content"), with: @article.content
    click_button I18n.t('helpers.submit.update')

    expect(find_field(I18n.t "#{p}.title").value).to eq new_title
    expect(current_path).to eq article_path(@article)
  end
end

feature 'Delete article' do
  scenario 'successfully' do
    user = sign_in as: :admin
    @article = article_editable_by_user create(:article), user
    visit edit_article_path(@article)

    expect{
      click_link I18n.t('delete_article')
    }.to change(Article, :count).by(-1)
    expect(current_path).to eq articles_path
    expect(page).to have_content I18n.t('article_was_successfully_deleted')
  end
end
