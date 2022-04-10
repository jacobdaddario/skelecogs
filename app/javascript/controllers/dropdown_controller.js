import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "button", "itemsContainer" ]
  static values = {
    open: { type: Boolean, default: false }
  }

  openValueChanged() {
    this.openValue ? this.toggleOpen() : this.toggleClosed()
  }

  toggle(event) {
    event && event.preventDefault()
    this.openValue = !this.openValue
  }

  toggleOpen() {
    this.itemsContainerTarget.style.display = "flex"
  }

  toggleClosed() {
    this.itemsContainerTarget.style.display = "none"
  }
}
