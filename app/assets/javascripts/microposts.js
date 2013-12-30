//#10.5.7 char count

//I put this here & referenced it in application.js w/jQuery cuz it
//was easier to read up on jQuery than to figure out how to call
//js in _micropost_form.html.erb's f.text_area
//cuz the call would somehow be document.form.micropost_content.value.length
//or something
function updateCountdown() {
        // 140 is the max message length
        var remaining = 140 - jQuery('#micropost_content').val().length;
        jQuery('.countdown').text(remaining + ' characters remaining');
    }

    jQuery(document).ready(function($) {
        updateCountdown();
        $('#micropost_content').change(updateCountdown);
        $('#micropost_content').keyup(updateCountdown);
    });
