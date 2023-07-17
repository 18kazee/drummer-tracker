import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reset-form"
export default class extends Controller {
  static targets = ["tweetField", "drummerField", "drummerHiddenField"];

  submitForm(event) {
    const form = this.element;
    form.addEventListener("turbo:submit-end", () => {
    this.tweetFieldTarget.value = "";
    this.drummerFieldTarget.value = "";
    this.drummerHiddenFieldTarget.value = "";
    });
  }
}
