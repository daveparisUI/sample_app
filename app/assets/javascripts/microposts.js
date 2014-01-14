//#10.5.7 char count

//I put this here & referenced it in application.js w/jQuery cuz it
//was easier to read up on jQuery than to figure out how to call
//js in _micropost_form.html.erb's f.text_area
//cuz the call would somehow be document.form.micropost_content.value.length
//or something

//JQuery = $; either can be used in code

function updateCountdown() {
        // 140 is the max message length
        var remaining = 140 - $('#micropost_content').val().length; //#micropost_content is object on pg, this code gets that obj
        $('.countdown').text(remaining + ' characters remaining'); //.countdown is class obj, puts "remaining" value onto pg
    }

    //once pg is loaded, is "ready"
    $(document).ready(function($) {
        updateCountdown(); //run function
        //anytime values change - like pasting in code, run funct
        $('#micropost_content').change(updateCountdown);
        //anytime text is entered, run funct
        $('#micropost_content').keyup(updateCountdown);
    });
