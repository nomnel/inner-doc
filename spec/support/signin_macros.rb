module SigninMacros
  def set_user_session user
    session[:user_id] = user.id
  end

  def sign_in
    pw = Faker::Internet.password
    user = create(:user, password: pw, password_confirmation: pw)

    visit signin_path
    p = 'helpers.label.user'
    fill_in I18n.t("#{p}.email"),    with: user.email
    fill_in I18n.t("#{p}.password"), with: pw
    click_button I18n.t('sign_in')

    user
  end
end