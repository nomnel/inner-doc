require 'spec_helper'

feature 'Sign up' do
  background do
    @user = build(:user)
  end

  scenario 'successfully' do
    visit new_user_path

    p = 'helpers.label.user'
    expect{
      fill_in I18n.t("#{p}.username"),              with: @user.username
      fill_in I18n.t("#{p}.email"),                 with: @user.email
      fill_in I18n.t("#{p}.password"),              with: @user.password
      fill_in I18n.t("#{p}.password_confirmation"), with: @user.password_confirmation
      click_button I18n.t('helpers.submit.create')
    }.to change(User, :count).by(1)

    expect(current_path).to eq root_path
    expect(page).to have_content I18n.t('registered_successfully')
  end

  scenario 'failed' do
    visit new_user_path

    p = 'helpers.label.user'
    expect{
      fill_in I18n.t("#{p}.username"),              with: nil
      fill_in I18n.t("#{p}.email"),                 with: @user.email
      fill_in I18n.t("#{p}.password"),              with: @user.password
      fill_in I18n.t("#{p}.password_confirmation"), with: @user.password_confirmation
      click_button I18n.t('helpers.submit.create')
    }.to_not change(User, :count)

    expect(current_path).to eq users_path
  end
end