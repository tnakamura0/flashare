require 'rails_helper'

include SystemHelper

RSpec.describe "Cards", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }

  describe "カードのCRUD" do
    describe "カードの一覧表示" do
      context "ログインしていない場合" do
        it "ログインページにリダイレクトされること" do
          visit cards_path
          expect(current_path).to eq login_path
          expect(page).to have_content('ログインしてください')
        end
      end

      context "ログイン済みの場合" do
        before do
          login_as(user)
        end

        it "カード一覧画面に遷移できること" do
          visit cards_path
          expect(current_path).to eq cards_path
        end

        it "正しいタイトルが表示されていること" do
          visit cards_path
          expect(page).to have_title "カード一覧"
        end

        context "カードが存在しない場合" do
          it "作成を勧めるメッセージが表示されること" do
            visit cards_path
            expect(page).to have_content "こちらからカードを作成しましょう！"
          end
        end

        context "カードが存在する場合" do
          let!(:card) { create(:card, user: user, name: 'テストカード', meaning: 'テスト') }

          it "カードが表示されること" do
            visit cards_path
            expect(page).to have_content 'テストカード'
          end
        end
      end
    end

    describe "カードの作成" do
      context "ログインしていない場合" do
        it "ログインページにリダイレクトされること" do
          visit new_card_path
          expect(current_path).to eq login_path
          expect(page).to have_content('ログインしてください')
        end
      end

      context "ログイン済みの場合" do
        before do
          login_as(user)
        end
        it "カード作成ページに遷移できること" do
          visit new_card_path
          expect(current_path).to eq new_card_path
        end

        it "カードの作成ができること" do
          expect {
            visit new_card_path
            fill_in 'カード名', with: 'らんてくん'
            fill_in '意味', with: 'キャラクター'
            click_button '登録'
          }.to change(Card, :count).by(1)

          expect(page).to have_content('カードを作成しました')
        end
      end
    end
  end
end
