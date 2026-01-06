class QuizSessionsController < ApplicationController
  before_action :deck_need_cards, only: %i[create]
  def index
    @quiz_sessions = current_user.quiz_sessions.pending
  end

  def create
    @quiz_session = current_user.quiz_sessions.build(
      deck: @deck,
      total_questions: @deck.cards.count,
      status: :pending
    )
    if @quiz_session.save
      redirect_to quiz_sessions_path, notice: t("defaults.flash_message.reserve_deck_question")
    else
      flash.now[:alert] = t("defaults.flash_message.not_reserve_deck_question")
      render "decks/show", status: :unprocessable_entity
    end
  end

  def destroy
    @quiz_session = current_user.quiz_sessions.find(params[:id])
    @quiz_session.destroy!
    redirect_to quiz_sessions_path, status: :see_other, notice: t("defaults.flash_message.deleted", item: QuizSession.model_name.human)
  end

  def start
    @quiz_session = current_user.quiz_sessions.find(params[:id])
    @quiz_session.update(status: :in_progress)
    redirect_to question_quiz_session_path(@quiz_session)
  end

  def question
    @quiz_session = current_user.quiz_sessions.find(params[:id])

    # 全問回答したら結果ページにリダイレクト
    if @quiz_session.all_answered?
      @quiz_session.update(status: :completed)
      redirect_to quiz_session_path(@quiz_session)
      return
    end

    @random_card = @quiz_session.random_card
  end

  def answer
    # 1問ごとに回答が送信されてくる
    @quiz_session = current_user.quiz_sessions.find(params[:id])
    @card = Card.find(params[:card_id])
    # answerを新規追加する（card_id: @card.id, quiz_session_id: @quiz_session.id, correct: params[:correct]）
    @answer = @quiz_session.answers.build(
      card: @card,
      correct: params[:correct]
    )

    # 回答結果を受け取ったらクイズページにリダイレクト
    if @answer.save
      redirect_to question_quiz_session_path(@quiz_session)
    else
      render :question, status: :unprocessable_entity
    end
  end

  def show
    # 最後の回答が送信された後に表示される結果ページ
    @quiz_session = current_user.quiz_sessions.find(params[:id])
    @answers = @quiz_session.answers
    @correct_number = @answers.where(correct: true).count
  end

  private

  def deck_need_cards
    @deck = Deck.find(params[:deck_id])
    unless @deck.cards.exists?
      flash.now[:alert] = t("defaults.flash_message.no_cards")
      render "decks/show", status: :unprocessable_entity
    end
  end
end
