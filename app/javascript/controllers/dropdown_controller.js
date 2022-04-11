import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "button", "itemsContainer" ]
  static classes = [ "reveal" ]
  static values = {
    open: { type: Boolean, default: false }
  }

  openValueChanged() {
    this.openValue ? this.toggleClosed() : this.toggleOpen()
  }

  toggle(event) {
    event && event.preventDefault()
    this.openValue = !this.openValue
  }

  toggleOpen() {
    this.revealClasses.forEach(klass => {
      this.itemsContainerTarget.classList.add(klass)
    });
  }

  toggleClosed() {
    this.revealClasses.forEach(klass => {
      this.itemsContainerTarget.classList.remove(klass)
    });
  }

  outsideClickHandler(event) {
    if (event.target != this.element && !this.element.contains(event.target)) {
      this.openValue = false
    }
  }

  escapeHandler(event) {
    if (event.keyCode == 27) {
      this.openValue = false
    }
  }
}
