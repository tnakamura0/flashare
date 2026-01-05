require 'rails_helper'

include SystemHelper

RSpec.describe Deck, type: :model do
  describe "正常系" do
    it "全てのフィールドが有効な場合に有効であること" do
      deck = build(:deck)
      expect(deck).to be_valid
    end

    it "デッキ名が36文字以下の場合に有効であること" do
      deck = build(:deck, name: "a" * 36)
      expect(deck).to be_valid
    end

    it "説明が存在しない場合に有効であること" do
      deck = build(:deck, description: nil)
      expect(deck).to be_valid
    end

    it "説明が72文字以内の場合に有効であること" do
      deck = build(:deck, description: "a" * 72)
      expect(deck).to be_valid
    end

    it "公開設定がtrueの場合に有効であること" do
      deck = build(:deck, public: true)
      expect(deck).to be_valid
      expect(deck.public).to eq true
    end

    it "公開設定がfalseの場合に有効であること" do
      deck = build(:deck, public: false)
      expect(deck).to be_valid
      expect(deck.public).to eq false
    end
  end

  describe "異常系" do
    it "デッキ名が存在しない場合に無効であること" do
      deck = build(:deck, name: nil)
      expect(deck).to be_invalid
      expect(deck.errors[:name]).to include("を入力してください")
    end

    it "デッキ名が37文字以上の場合に無効であること" do
      deck = build(:deck, name: "a" * 37)
      expect(deck).to be_invalid
      expect(deck.errors[:name]).to include('は36文字以内で入力してください')
    end

    it "説明が73文字以上の場合に無効であること" do
      deck = build(:deck, description: "a" * 73)
      expect(deck).to be_invalid
      expect(deck.errors[:description]).to include('は72文字以内で入力してください')
    end

    it "公開設定がnilの場合に無効であること" do
      deck = build(:deck, public: nil)
      expect(deck).to be_invalid
      expect(deck.public).to be_nil
      expect(deck.errors[:public]).to include("は一覧にありません")
    end
  end
end
