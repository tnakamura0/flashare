require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "ユーザー新規登録画面に遷移できること" do
    visit new_user_path
    expect(page).to have_text("ユーザー登録")
  end

  context '入力情報正常系' do
    it 'ユーザーが新規作成できること' do
      # 現在のユーザー数を記録(環境に依存しない)
      expect {
        visit '/users/new'
        fill_in 'ユーザー名', with: 'らんてくん'
        fill_in 'メールアドレス', with: 'example@example.com'
        fill_in 'パスワード', with: '12345678'
        fill_in 'パスワード確認', with: '12345678'
        click_button '登録'
      }.to change(User, :count).by(1)  # 1件増えたことを確認

      expect(page).to have_content('ユーザー登録が完了しました')
    end
  end

  context '入力情報異常系' do
    it 'ユーザーが新規作成できない' do
      visit new_user_path
      fill_in 'メールアドレス', with: 'example@example.com'
      click_button '登録'
      expect(page).to have_content('ユーザー登録に失敗しました')
      expect(page).to have_content('ユーザー名は2文字以上で入力してください')
      expect(page).to have_content('ユーザー名を入力してください')
      expect(page).to have_content('パスワードを入力してください')
      expect(page).to have_content('パスワードは8文字以上で入力してください')
      expect(page).to have_content('パスワード確認とパスワードの入力が一致しません')
    end
  end
end
