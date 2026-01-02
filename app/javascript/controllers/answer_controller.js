import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="switch-answer-button"
export default class extends Controller {
  static targets = [ "showAnswer", "answerButton" ]

  switchButton() {
    this.showAnswerTarget.classList.toggle("hidden")
    this.answerButtonTarget.classList.toggle("hidden")
  }
}
