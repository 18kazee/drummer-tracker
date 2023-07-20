import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="animation"
export default class extends Controller {
static targets = ['title', 'text', 'section', 'image'];
  connect() {
    this.hideText();
    this.hideImage();
    this.animationTitle();
    window.addEventListener('scroll', this.handleScroll.bind(this));
  }
  hideText() {
    const textElement = this.textTarget;
    if (textElement) {
    textElement.classList.add('hidden');
    }
  }
  hideImage() {
    const imageElement = this.imageTarget;
    imageElement.classList.add('hidden');
  } 

  animationTitle() {
    const titleElement = this.titleTarget;
    titleElement.addEventListener('animationend', () => {
      this.showText();
    });
    titleElement.classList.add('focus-in-contract-bck');
  }

  showText() {
    const textElement = this.textTarget;
    if (textElement) {
    textElement.classList.remove('hidden');
    textElement.classList.add('text-focus-in');
    }
  }
  scrollToSection() {
    const sectionElement = this.sectionTarget;
    if (sectionElement) {
      const offsetTop = sectionElement.offsetTop;
      window.scrollTo({
        top: offsetTop,
        behavior: 'smooth'
      });
    }
  }
 handleScroll() {
  const imageElements = this.imageTargets;
  imageElements.forEach((imageElement) => {
    if (this.isElementInViewport(imageElement)) {
      imageElement.classList.remove('hidden');
      imageElement.classList.add('focus-in-expand-fwd');
      // 追加のアクションが必要な場合は追加してください
    }
  });
 }
 isElementInViewport(element) {
    const rect = element.getBoundingClientRect();
    return (
      rect.top >= 0 &&
      rect.left >= 0 &&
      rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
      rect.right <= (window.innerWidth || document.documentElement.clientWidth)
    );
  }
}
