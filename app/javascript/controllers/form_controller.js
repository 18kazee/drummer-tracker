import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  submit() {
    clearTimeout(this.timeout)
// Wait 500ms before submitting the form
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 500)
  }
}
