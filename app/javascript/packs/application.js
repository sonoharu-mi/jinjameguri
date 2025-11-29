// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 

//import "./map_index";
//import "./map_form";
import './calendar';

Rails.start()
//Turbolinks.start()
ActiveStorage.start()

window.waitForGoogleMaps = function () {
  return new Promise((resolve) => {
    if (window.google && window.google.maps) {
      resolve();
      return;
    }
    const timer = setInterval(() => {
      if (window.google && window.google.maps) {
        clearInterval(timer);
        resolve();
      }
    }, 50);
  });
};


