import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon1", "icon2", "input1", "icon3", "icon4", "input2"]
  connect() {
    // console.log("hello")
    // Do what you want here.
  }

  password1(event) {
    console.log(this.icon2Target.classList.constructor)
    console.log(this.icon2Target.classList.contains('d-none'))
    if (this.icon2Target.classList.contains('d-none')) {
      this.icon2Target.classList.remove('d-none')
      this.icon1Target.classList.add('d-none')
      this.input1Target.type = "text"
    } else {
      this.icon2Target.classList.add('d-none')
      this.icon1Target.classList.remove('d-none')
      this.input1Target.type = "password"
    }
  }
  password2(event) {
    if (this.icon4Target.classList.contains('d-none')) {
      this.icon4Target.classList.remove('d-none')
      this.icon3Target.classList.add('d-none')
      this.input2Target.type = "text"
    } else {
      this.icon4Target.classList.add('d-none')
      this.icon3Target.classList.remove('d-none')
      this.input2Target.type = "password"
    }
  }
}
