import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "button", "itemsContainer" ]
  static classes = [ "reveal" ]
  static values = {
    open: { type: Boolean, default: false }
  }

  openValueChanged() {
    this.toggleReveal()
  }

  toggle(event) {
    event && event.preventDefault()
    this.openValue = !this.openValue
  }

  toggleReveal() {
    this.revealClasses.forEach(klass => {
      this.itemsContainerTarget.classList.toggle(klass)
    });
  }
}
