var ShowPassword = {
  config: {
    color: "#666666"
  },
  get svgStyles() {
    return {
      position: "absolute",
      right: "10px",
      margin: "auto 0",
      top: "0",
      bottom: "0",
      cursor: "pointer",
      fill: this.config.color
    }
  },
  initialize: function() {
    var passwordShowHideField = document.getElementById("showHidePassword")
    passwordShowHideField.setAttribute("style", "position: relative;")

    var visibilityOnSVG = `<svg version="1.1" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" id="visibilityOnSVG">
<title>visibility</title>
<path d="M12 9c1.641 0 3 1.359 3 3s-1.359 3-3 3-3-1.359-3-3 1.359-3 3-3zM12 17.016c2.766 0 5.016-2.25 5.016-5.016s-2.25-5.016-5.016-5.016-5.016 2.25-5.016 5.016 2.25 5.016 5.016 5.016zM12 4.5c5.016 0 9.281 3.094 11.016 7.5-1.734 4.406-6 7.5-11.016 7.5s-9.281-3.094-11.016-7.5c1.734-4.406 6-7.5 11.016-7.5z"></path>
</svg>`

    var visibilityOffSVG = `<svg version="1.1" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" id="visibilityOffSVG">
<title>visibility_off</title>
<path d="M11.859 9h0.141c1.641 0 3 1.359 3 3v0.188zM7.547 9.797c-0.328 0.656-0.563 1.406-0.563 2.203 0 2.766 2.25 5.016 5.016 5.016 0.797 0 1.547-0.234 2.203-0.563l-1.547-1.547c-0.188 0.047-0.422 0.094-0.656 0.094-1.641 0-3-1.359-3-3 0-0.234 0.047-0.469 0.094-0.656zM2.016 4.266l1.266-1.266 17.719 17.719-1.266 1.266c-1.124-1.11-2.256-2.213-3.375-3.328-1.359 0.563-2.813 0.844-4.359 0.844-5.016 0-9.281-3.094-11.016-7.5 0.797-1.969 2.109-3.656 3.75-4.969-0.914-0.914-1.812-1.844-2.719-2.766zM12 6.984c-0.656 0-1.266 0.141-1.828 0.375l-2.156-2.156c1.219-0.469 2.578-0.703 3.984-0.703 5.016 0 9.234 3.094 10.969 7.5-0.75 1.875-1.922 3.469-3.422 4.734l-2.906-2.906c0.234-0.563 0.375-1.172 0.375-1.828 0-2.766-2.25-5.016-5.016-5.016z"></path>
</svg>`

    passwordShowHideField.innerHTML += visibilityOnSVG
    passwordShowHideField.innerHTML += visibilityOffSVG

    visibilityOnElement  = document.getElementById("visibilityOnSVG")
    visibilityOffElement = document.getElementById("visibilityOffSVG")

    this.setStyles(this.svgStyles, visibilityOnElement)
    this.setStyles(this.svgStyles, visibilityOffElement)

    this.hide(visibilityOffElement)

    visibilityOnElement.addEventListener("click", function(e) {
      var input = this.getInput(e)

      this.changeInputToText(input)
      this.hide(visibilityOnElement)
      this.show(visibilityOffElement)
    }.bind(this))

    visibilityOffElement.addEventListener("click", function(e) {
      var input = this.getInput(e)

      this.changeInputToPassword(input)
      this.show(visibilityOnElement)
      this.hide(visibilityOffElement)
    }.bind(this))
  },
  getInput: function(event) {
    return event.target.parentElement.parentElement.querySelector("input")
  },
  hide: function(element) {
    this.setStyles({ display: "none" }, element)
  },
  show: function(element) {
    this.setStyles({ display: "inline" }, element)
  },
  setStyles: function(styles, element) {
    Object.assign(element.style, styles);
  },
  changeInputToText: function(input) {
    input.setAttribute("type", "text")
  },
  changeInputToPassword: function(input) {
    input.setAttribute("type", "password")
  }
}

if (typeof module !== 'undefined' && typeof module.exports !== 'undefined') {
  module.exports = ShowPassword;
} else {
  window.ShowPassword = ShowPassword;
}
