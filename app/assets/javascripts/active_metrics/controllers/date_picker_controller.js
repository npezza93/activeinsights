import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["picker"]

  connect() {
    const date = new Date()

    let day = date.getDate()
    let month = date.getMonth() + 1
    let year = date.getFullYear()

    month = month < 10 ? '0' + month : month
    day = day < 10 ? '0' + day : day


    let currentDate = `${year}-${month}-${day}`

    this.pickerTarget.max = currentDate
    if (this.pickerTarget.value === "") {
      this.pickerTarget.value = currentDate
    }

    this.pickerTarget.dateAdapter = {
      format(date) {
        return formatDate(date)
      }
    }
  }

  toggle() {
      this.pickerTarget.show()
  }

  async hide() {
    await this.pickerTarget.hide(true)
  }
}

  function formatDate(dateToFormat) {
    const date = new Date(dateToFormat);

    const options = { month: 'long', day: 'numeric' };
    let formattedDate = date.toLocaleDateString('en-US', options);

    const currentYear = new Date().getFullYear();
    if (date.getFullYear() !== currentYear) {
      formattedDate += ', ' + date.getFullYear();
    }

    return formattedDate;
  }
