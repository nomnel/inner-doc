require 'spec_helper'

feature 'Create article' do
  background do
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
    @article = create(:article)
  end

  scenario 'successfully' do
    visit edit_article_path(@article)

    p = 'helpers.label.article'
    new_title = 'My Title'
    fill_in I18n.t("#{p}.title"),   with: new_title
    fill_in I18n.t("#{p}.content"), with: @article.content
    click_button I18n.t('helpers.submit.update')

    expect(find_field(I18n.t "#{p}.title").value).to eq new_title
    expect(current_path).to eq edit_article_path(@article)
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