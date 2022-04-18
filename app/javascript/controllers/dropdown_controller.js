import { Controller } from "@hotwired/stimulus"
import { isFocusableElement, focusEligibleElement  } from "../utils/focusable_helpers"
import keyboard from "../utils/keyboard"

export default class extends Controller {
  static targets = [ "button", "itemsContainer", "item" ]
  static classes = [ "reveal" ]
  static values = {
    open: { type: Boolean, default: false },
    index: { type: Number, default: -1 }
  }

  openValueChanged() {
    this.openValue ? this.toggleOpen() : this.toggleClosed()
  }

  indexValueChanged() {
    if (this.indexValue >= 0) {
      focusEligibleElement(this.itemTargets[this.indexValue])
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
      this.itemsContainerTarget.classList.remove(klass)
    });
  }

  toggleClosed() {
    this.revealClasses.forEach(klass => {
      this.itemsContainerTarget.classList.add(klass)
    });
    this.indexValue = -1
  }

  outsideClickHandler(event) {
    if (event.target != this.element && !this.element.contains(event.target) && this.openValue == true) {
      this.openValue = false

      var focusable = isFocusableElement(event.target)
      if (!focusable) {
        this.buttonTarget.focus()
      }
    }
  }

  outsideKeyHandler(event) {
    if (event.keyCode == keyboard.escape) {
      this.openValue = false
    }
  }

  keyHandler(event) {
    var maxIndex = this.itemTargets.length - 1

    switch(event.keyCode) {
      case keyboard.enter:
        event.preventDefault()
        // This might be an egregious style error, but it looks like Ruby and makes me happy
        if (document.activeElement == this.itemsContainerTarget) { this.buttonTarget.click(); return }

        document.activeElement.click()

        if (document.activeElement == this.buttonTarget) {
          this.indexValue = this.itemTargets.findIndex((elem) => !elem.getAttribute("disabled"))
        }
        if (this.itemTargets.includes(document.activeElement)) {
          this.buttonTarget.focus()
        }
        break
      case keyboard.space:
        document.activeElement.click()
        break
      case keyboard.upArrow:
        if (this.indexValue > 0) {
          this.indexValue -= 1
        } else {
          this.indexValue = maxIndex
        }
        break
      case keyboard.downArrow:
        if (this.indexValue < maxIndex) {
          this.indexValue += 1
        } else {
          this.indexValue = 0
        }
        break
    }
  }

  afterSelection(event) {
    if (this.silenceEventsOnDisabled(event)) return

    this.openValue = false
  }

  setActive(event) {
    if (this.silenceEventsOnDisabled(event)) return

    this.itemsContainerTarget.setAttribute("aria-activedescendant", event.currentTarget.id)
  }

  removeActive(event) {
    if (this.silenceEventsOnDisabled(event)) return

    this.itemsContainerTarget.removeAttribute("aria-activedescendant")
  }

  silenceEventsOnDisabled(event) {
    if (event.currentTarget.getAttribute("disabled")) {
      event.preventDefault()
      event.target.blur()

      return true
    }
  }
}
