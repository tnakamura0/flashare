import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hamburger"
export default class extends Controller {
  static targets = [ "hamburgerLine1", "hamburgerLine2", "hamburgerLine3", "hamburgerMenu", "overlay" ]

  switchMenu() {
    this.hamburgerLine1Target.classList.toggle("top-4")
    this.hamburgerLine1Target.classList.toggle("top-6")
    this.hamburgerLine1Target.classList.toggle("-rotate-45")

    this.hamburgerLine2Target.classList.toggle("opacity-0")

    this.hamburgerLine3Target.classList.toggle("top-8.5")
    this.hamburgerLine3Target.classList.toggle("top-6")
    this.hamburgerLine3Target.classList.toggle("rotate-45")

    this.hamburgerMenuTarget.classList.toggle("-right-4/5")
    this.hamburgerMenuTarget.classList.toggle("right-0")

    this.overlayTarget.classList.toggle("hidden")
  }
}
