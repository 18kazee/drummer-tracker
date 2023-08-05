import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="youtube"
export default class extends Controller {
  static targets = ["thumbnails"];

  connect() {
    this.thumbnailsTargets.forEach(thumbnail => {
      thumbnail.addEventListener("click", this.changeVideo.bind(this), { passive: true });
    });
  }

  changeVideo(event) {
    event.stopPropagation();
    const videoId = event.currentTarget.getAttribute("data-video-id");
    
    if (videoId) {
      const videoUrl = `https://www.youtube.com/embed/${videoId}`;
      const iframe = document.getElementById("video-iframe");
      iframe.src = videoUrl;
    } else {
      console.log("No video id found");
    }
  }

  closeModal() {
    const iframe = document.getElementById("video-iframe");
    iframe.src = ""; // Set the src to empty to stop the video
  }
}
