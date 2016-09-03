// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.autocomplete.min
//= require classie
//= require selectFx
//= require tooltipster.bundle
//= require jquery.growl
//= require awesomplete
//= require cocoon
//= require_tree .


window.LoadAutocomplete = function() {

  $('[data-autocomplete]').each(function() {
    var $this = $(this);
    var url = $(this).attr("data-url");
    $(this).autocomplete({
      serviceUrl: url,
      onSelect: function(suggestion) {
        $this.val(suggestion.value);
      }
    })
  })

}


$(document).on('turbolinks:load', function() {

  $('#new-player input[type=submit]').click(function(evt) {
    evt.preventDefault();
    var $form = $('#new-player form');

    $.ajax({
      url: $form.attr('action'),
      method: $form.attr('method'),
      data: $form.serialize(),
      dataType: 'json',
      beforeSend: function() {

      },
      success: function(data) {
        $.growl.notice({ title: 'Create Player', message: 'Player created successfully!' });
        $.getScript(data.path);
        $('#new-player').removeClass('active');
      },
      error: function() {
        $.growl.error({ title: 'Create Player', message: 'Failed to create player' });
      },
      complete: function() {
      }
    })
  });

  $('[data-modal]').click(function(evt) {
    evt.preventDefault();
    var selector = $(this).attr('data-modal');
    $(selector).addClass('active');
  });

  $('select.cs-select').each(function() {
    var $select = $(this);
    new SelectFx(this, {
      onChange: function(val) {
        console.log("Set value to: ", val);
        $select.val(val);
      }
    });
  });

  $('.tooltip').tooltipster({
    theme: 'tooltipster-punk',
    side: 'right'
  });



  $('.form-modal .background').each(function() {
    $(this).click(function(evt) {
      $(this).parent().removeClass('active');
    });
  });

  $(".add-money").on("click touchend", function(evt) {
    evt.preventDefault();

    var $this = $(this);
    var $input = $("#player_money");
    var amount = parseInt($this.attr('data-amount'));
    var value = parseInt($input.val());
    if (!isNaN(amount)) {
      if (isNaN(value)) value = 0;
      value += amount;
      $input.val(value);
    }
  });

  $(".add-darkstone").on("click touchend", function(evt) {
    evt.preventDefault();

    var $this = $(this);
    var $input = $("#player_darkstone");
    var amount = parseInt($this.attr('data-amount'));
    var value = parseInt($input.val());

    if (!isNaN(amount)) {
      if (isNaN(value)) value = 0;
      value += amount;
      $input.val(value);
    }
  });

  $(".add-xp").on("click touchend", function(evt) {
    evt.preventDefault();

    var $this = $(this);
    var $input = $("#player_xp");
    var amount = parseInt($this.attr('data-amount'));
    var value = parseInt($input.val());

    if (!isNaN(amount)) {
      if (isNaN(value)) value = 0;
      value += amount;
      $input.val(value);
    }
  });

  $(".minus").on("click touchend", function(evt) {
    evt.preventDefault();

    var $this = $(this);
    var $input = $this.parent().parent().find('input');
    var value = parseInt($input.val());

    if (isNaN(value)) value = 0;
    value -= 1;
    $input.val(value);
  });

  $(".plus").on('click touchend', function(evt) {
    evt.preventDefault();

    var $this = $(this);
    var $input = $this.parent().parent().find('input');
    var value = parseInt($input.val());

    if (isNaN(value)) value = 0;
    value += 1;
    $input.val(value);
  });

  $("#stat-mod-fields,#item-stat-mod-fields").on("cocoon:after-insert", function(evt, item) {
    item.find(".minus").on("click touchend", function(evt) {
      evt.preventDefault();

      var $this = $(this);
      var $input = $this.parent().parent().find('input');
      var value = parseInt($input.val());

      if (isNaN(value)) value = 0;
      value -= 1;
      $input.val(value);
    });

    item.find(".plus").on("click touchend", function(evt) {
      evt.preventDefault();

      var $this = $(this);
      var $input = $this.parent().parent().find('input');
      var value = parseInt($input.val());

      if (isNaN(value)) value = 0;
      value += 1;
      $input.val(value);
    });

    item.find('select').each(function() {
      var $select = $(this);
      new SelectFx(this, {
        onChange: function(val) {
          console.log("Set value to: ", val);
          $select.val(val);
        }
      });
    });
  });

  $("a.destroy").on("ajax:success", function(e, data, status, xhr) {
    $(this).parent().remove();
  });


});
