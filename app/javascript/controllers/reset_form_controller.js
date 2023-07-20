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
  
      // 現在のURLのパス部分とクエリストリングを取得
      const currentUrl = window.location.href;
      const currentPath = window.location.pathname;
      const queryString = window.location.search;
  
      // 条件分岐: 現在のURLが/postsで終わっている場合は何もしない、それ以外は/postsにリダイレクト
      if (currentPath === "/posts" && queryString === "") {
        // 現在のURLが/postsで終わっている場合の処理
        // 何もしない（リダイレクトせずにそのまま表示する）
      } else {
        // 現在のURLが/postsで終わっていない場合の処理またはクエリストリングが存在する場合の処理
        setTimeout(() => {
          window.location.href = "/posts"; // あなたの実際のルートに適したパスを指定してください
        }, 2000);
      }
    });
  }}
