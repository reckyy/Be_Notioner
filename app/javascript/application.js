// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// app/javascript/packs/application.js
$(document).ready(function(){
  $("#popular-button").click(function(){
    $.ajax({
      url: "/popular",
      type: "GET",
      dataType: "script"
    });
  });
});
