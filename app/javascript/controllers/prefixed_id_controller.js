import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    prefix: String
  }

  connect() {
    if (!this.hasPrefixValue) {
      throw new Error("Prefix is a required argument and is not present.")
    }

    this.element.id = `${this.prefixValue}-${this.newIdNumber}`
  }

  get siblingElements() {
    return document.querySelectorAll(`[id^='${this.prefixValue}']`)
  }

  get existingNumbers() {
    var elements = Array.from(this.siblingElements)
    return elements.map(elem => elem.id.replace(/^\D+/g, '') )
  }

  get newIdNumber() {
    if (this.existingNumbers.length <= 0) {
      return 1
    } else {
      return Math.max(...this.existingNumbers) + 1
    }
  }
}
