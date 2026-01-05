require 'rails_helper'

include SystemHelper

RSpec.describe Card, type: :model do
  describe "正常系" do
    it "全てのフィールドが有効な場合に有効であること" do
      card = build(:card)
      expect(card).to be_valid
    end

    it "カード名が18文字以下の場合に有効であること" do
      card = build(:card, name: "a" * 18)
      expect(card).to be_valid
    end

    it "意味が36文字以内の場合に有効であること" do
      card = build(:card, meaning: "a" * 36)
      expect(card).to be_valid
    end
  end

  describe "異常系" do
    it "カード名が存在しない場合に無効であること" do
      card = build(:card, name: nil)
      expect(card).to be_invalid
      expect(card.errors[:name]).to include("を入力してください")
    end

    it "意味が存在しない場合に無効であること" do
      card = build(:card, meaning: nil)
      expect(card).to be_invalid
      expect(card.errors[:meaning]).to include("を入力してください")
    end

    it "カード名が19文字以上の場合に無効であること" do
      card = build(:card, name: "a" * 19)
      expect(card).to be_invalid
      expect(card.errors[:name]).to include('は18文字以内で入力してください')
    end

    it "意味が37文字以上の場合に無効であること" do
      card = build(:card, meaning: "a" * 37)
      expect(card).to be_invalid
      expect(card.errors[:meaning]).to include('は36文字以内で入力してください')
    end
  end
end
