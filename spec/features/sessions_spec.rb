require 'spec_helper'

feature 'Sign in' do
  background do
    @pw = Faker::Internet.password
    @user = create(:user, password: @pw, password_confirmation: @pw)
  end

  scenario 'successfully' do
    visit signin_path

    p = 'helpers.label.user'
    fill_in I18n.t("#{p}.email"),    with: @user.email
    fill_in I18n.t("#{p}.password"), with: @pw
    click_button I18n.t('sign_in')

    expect(current_path).to eq root_path
    expect(page).to have_content I18n.t('signed_in_successfully')
  end

  scenario 'failed' do
    visit signin_path

    p = 'helpers.label.user'
    fill_in I18n.t("#{p}.email"),    with: @user.email
    fill_in I18n.t("#{p}.password"), with: nil
    click_button I18n.t('sign_in')

    expect(current_path).to eq sessions_path
    expect(page).to have_content I18n.t('invalid_email_or_password')
  end
end