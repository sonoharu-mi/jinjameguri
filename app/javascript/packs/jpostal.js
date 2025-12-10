document.addEventListener('DOMContentLoaded', function() {
  window.jpostal = function() {
    console.log("test");
    $('#zipcode').jpostal({
      postcode : ['#zipcode'],
      address : {
        '#post_address': '%3%4%5'
      }
    });
  }
});
// $(document).on("turbolinks:load", jpostal);