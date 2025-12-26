class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    card = current_user.cards.build(card_params)
    if card.save
      redirect_to cards_path, notice: t("defaults.flash_message.created", item: Card.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_created", item: Card.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  # Cardの詳細ページは現状不要なのでルーティングから除外した
  # 今後使用するかもしれないのでコードは残す
  # def show
  #   @card = current_user.cards.find(params[:id])
  # end

  def edit
    @card = current_user.cards.find(params[:id])
  end

  def update
    @card = current_user.cards.find(params[:id])
    if @card.update(card_params)
      redirect_to cards_path, notice: t("defaults.flash_message.updated", item: Card.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: Card.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    card = current_user.cards.find(params[:id])
    card.destroy!
    redirect_to cards_path, status: :see_other, notice: t("defaults.flash_message.deleted", item: Card.model_name.human)
  end

  private

  def card_params
    params.require(:card).permit(:name, :meaning)
  end
end
