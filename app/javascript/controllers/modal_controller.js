import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    this.modal = new Modal(this.element)
    this.element.addEventListener("hidden.bs.modal", this.closeModal.bind(this));
    this.modal.show()
  }

  close(event) {
      this.modal.hide()

    }

  closeModal() {
    // Your existing closeModal logic to stop the video
    const iframe = document.getElementById("video-iframe");
    iframe.src = ""; // Set the src to empty to stop the video

  }
}
