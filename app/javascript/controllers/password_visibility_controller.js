import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // static targets = ["show", "unhide"]
  static targets = ["icon", "input"]
  connect() {
    // console.log("hello")
    // Do what you want here.
  }

  password(event) {
    console.log("hello")
    console.log(this.iconTarget)
    this.iconTarget.classList.remove('d-none')
    // Do what you want here
  }
}
