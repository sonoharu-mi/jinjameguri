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
// import './calendar';
// import '/jquery_app.js'

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

document.addEventListener("DOMContentLoaded", () => {
  const tabs = document.querySelectorAll('#postTabs .nav-link');
  const myPosts = document.getElementById('my-posts');
  const likedPosts = document.getElementById('liked-posts');

  if (!tabs.length) return;

  tabs.forEach(tab => {
    tab.addEventListener('click', () => {

      // タブの active 切替
      tabs.forEach(t => t.classList.remove('active'));
      tab.classList.add('active');

      // コンテンツの切替
      if (tab.dataset.tab === "my-posts") {
        myPosts.style.display = 'block';
        likedPosts.style.display = 'none';
      } else if (tab.dataset.tab === "liked-posts") {
        myPosts.style.display = 'none';
        likedPosts.style.display = 'block';
      }
    });
  });
});

