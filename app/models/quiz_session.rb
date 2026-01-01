class QuizSession < ApplicationRecord
  belongs_to :user
  belongs_to :deck
  has_many :answers, dependent: :destroy

  enum status: { pending: 0, in_progress: 1, completed: 2 }

  def answered_cards_ids
    # 既に回答したカードのIDリスト
    self.answers.pluck(:card_id)
  end

  def unanswered_cards
    # まだ回答していないカードを取得するメソッド
    self.deck.cards.where.not(id: answered_cards_ids)
  end

  def random_card
    # ランダムなカードを出題するインスタンスメソッド
    # まだ回答していないカードから出題する

    # カード数が少ない場合はRubyの配列のメソッドであるsampleメソッドで実装してもいい
    # unanswered_cards.sample
    unanswered_cards.order(Arel.sql("RANDOM()")).first
  end

  def answered_count
    # 回答した問題数
    self.answers.count
  end

  def all_answered?
    answered_count >= self.total_questions
  end
end
