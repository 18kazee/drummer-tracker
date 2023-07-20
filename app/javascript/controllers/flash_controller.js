import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["messages1"];
  connect() {
    this.showFlashMessage();
  }
showFlashMessage() {
  if (this.messages1Target.innerHTML.trim() !== "") {
    // フラッシュメッセージが存在する場合は一定時間後に非表示にする
    setTimeout(() => {
      this.messages1Target.classList.add("hidden");
    }, 3000); // 3秒後に非表示にする（任意の時間を設定可能）
  }
}
}
