# ShowPassword

The easiest way to show and hide the text inside a password field.

![demo](https://d2ffutrenqvap3.cloudfront.net/items/0d2X0O2k1p1w1Z2W0I3Y/Screen%20Recording%202018-02-08%20at%2020.13.gif?X-CloudApp-Visitor-Id=2108595)

## Install

`npm install show_password --save`

## Usage

Note: To use in a Node project, you'll have to use a package like [jsdom](https://github.com/jsdom/jsdom) to access to `document` object.

```javascript
var ShowPassword = require('show_password')

ShowPassword.initialize()
```

Add a wrapper `div` with an `id` of `showPassword` around your password input field.

```html
<div class="showPassword">
  <input type="password">
</div>
```

That's it!

### Rails setup

`yarn add show_password`

Then, add the following to `application.js`:

```javascript
//= require show_password/show_password
```

## Configuration

You can use the `ShowPassword.config` object to configure ShowPassword.

`config.color`: Change the color of the visibility icons.


## Author
[Garrett Martin](https://sturdy.work)
