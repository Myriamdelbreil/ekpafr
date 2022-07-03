import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input1", "input2", "input2"]
  connect() {
    console.log("hello")
    // Do what you want here.
  }
}
