require 'rails_helper'

include SystemHelper

RSpec.describe "UserSessions", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "ログイン" do
    it "ログイン画面に遷移できること" do
      visit login_path
      expect(page).to have_title("ログイン")
    end
  end

  context "認証情報が正しい場合" do
    let(:user) { create(:user) }
    it "ログインできること" do
      visit login_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"
      expect(current_path).to eq root_path
      expect(page).to have_content "ログインしました"
    end
  end

  context "パスワードに誤りがある場合" do
    let(:user) { create(:user) }
    it "ログインできないこと" do
      visit login_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: "87654321"
      click_button "ログイン"
      expect(current_path).to eq login_path
      expect(page).to have_content "ログインに失敗しました"
    end
  end

  describe "ログアウト" do
    let(:user) { create(:user) }
    before do
      login_as(user)
    end
    xit "ログアウトできること" do
      click_link "ログアウト"
      expect(page).to have_content "ログアウトしました" do
        # リダイレクト後のパスを確認するためにブロックにする
        expect(current_path).to eq root_path
      end
    end
  end
end
