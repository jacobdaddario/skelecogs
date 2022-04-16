import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "button", "itemsContainer", "item" ]
  static classes = [ "reveal" ]
  static values = {
    open: { type: Boolean, default: false },
    index: { type: Number, default: -1 }
  }

  openValueChanged() {
    this.openValue ? this.toggleClosed() : this.toggleOpen()
  }

  indexValueChanged() {
    if (this.indexValue >= 0) {
      this.itemTargets[this.indexValue].querySelector('a[href]', 'button:not([disabled])').focus()
    } else {
      this.itemsContainerTarget.focus()
    }
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
    this.indexValue = -1
  }

  outsideClickHandler(event) {
    if (event.target != this.element && !this.element.contains(event.target) && this.openValue == true) {
      this.openValue = false
      this.buttonTarget.focus()
    }
  }

  escapeHandler(event) {
    if (event.keyCode == 27) {
      this.openValue = false
    }
  }

  keyHandler(event) {
    if (this.openValue == true) {
      this.navKeyHandler(event)
    } else {
      this.revealKeyHandler(event)
    }
  }

  navKeyHandler(event) {
    var maxIndex = this.itemTargets.length - 1

    switch(event.keyCode) {
      case 13:
        document.activeElement.click()
        break
      case 32:
        document.activeElement.click()
        break
      case 38:
        if (this.indexValue > 0) {
          this.indexValue -= 1
        } else {
          this.indexValue = maxIndex
        }
        break
      case 40:
        if (this.indexValue < maxIndex) {
          this.indexValue += 1
        } else {
          this.indexValue = 0
        }
        break
    }
  }
}
