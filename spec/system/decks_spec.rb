require 'rails_helper'

include SystemHelper

RSpec.describe "Decks", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }

  describe "デッキのCRUD" do
    describe "デッキの一覧表示" do
      context "ログインしていない場合" do
        it "ログインページにリダイレクトされること" do
          visit decks_path
          expect(current_path).to eq login_path
          expect(page).to have_content('ログインしてください')
        end
      end

      context "ログイン済みの場合" do
        before do
          login_as(user)
        end

        it "カード一覧画面に遷移できること" do
          visit decks_path
          expect(current_path).to eq decks_path
        end

        it "正しいタイトルが表示されていること" do
          visit decks_path
          expect(page).to have_title "デッキ一覧"
        end

        context "デッキが存在しない場合" do
          it "作成を勧めるメッセージが表示されること" do
            visit decks_path
            expect(page).to have_content "こちらからデッキを作成しましょう！"
          end
        end

        context "デッキが存在する場合" do
          let!(:deck) { create(:deck, user: user, name: 'テストデッキ', description: 'テスト') }

          it "デッキが表示されること" do
            visit decks_path
            expect(page).to have_content 'テストデッキ'
          end
        end
      end
    end

    describe "デッキの作成" do
      context "ログインしていない場合" do
        it "ログインページにリダイレクトされること" do
          visit new_deck_path
          expect(current_path).to eq login_path
          expect(page).to have_content('ログインしてください')
        end
      end

      context "ログイン済みの場合" do
        before do
          login_as(user)
        end
        it "デッキ作成ページに遷移できること" do
          visit new_deck_path
          expect(current_path).to eq new_deck_path
        end

        it "デッキの作成ができること" do
          expect {
            visit new_deck_path
            fill_in 'デッキ名', with: 'テストデッキ'
            fill_in '説明', with: 'デッキの説明'
            click_button '登録'
          }.to change(Deck, :count).by(1)

          expect(page).to have_content('デッキを作成しました')
        end

        it "入力をしなかった場合にデッキの作成ができないこと" do
          expect {
            visit new_deck_path
            click_button '登録'
          }.to change(Deck, :count).by(0)

          expect(current_path).to eq decks_path
          expect(page).to have_content('デッキを作成出来ませんでした')
        end
      end
    end

    describe "デッキの編集" do
      let!(:deck) { create(:deck, user: user, name: 'テストデッキ', description: 'テスト') }
      context "ログイン済みの場合" do
        before do
          login_as(user)
        end
        it "カードの編集ができること" do
          visit edit_deck_path(deck)
          expect(current_path).to eq edit_deck_path(deck)
          fill_in "デッキ名", with: "テストデッキ（編集後）"
          click_button "更新"
          expect(page).to have_content "デッキを更新しました"
          expect(current_path).to eq deck_path(deck)
        end
      end
    end

    describe "デッキの削除" do
      let!(:deck) { create(:deck, user: user, name: 'テストデッキ', description: 'テスト') }
      context "ログイン済みの場合" do
        before do
          login_as(user)
        end
        it "デッキの削除ができること" do
          expect {
            visit decks_path
            click_button "削除"
        }.to change(Deck, :count).by(-1)
        end
      end
    end
  end
end
