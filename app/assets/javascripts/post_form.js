$(document).on('turbolinks:load', function() {

    var textarea = document.getElementById('post_content');
    console.log(textarea);

    var char = document.getElementById('characters');
    var create_post_submit = document.getElementById('create_post_submit');
    console.log(char);
    create_post_submit.disabled = true;


    textarea.addEventListener('input', function() {
        console.log(textarea.value.length);



        if (textarea.value.length > 400 ) {
            char.innerHTML = 400 - textarea.value.length;
            char.style.color = "red";
            create_post_submit.disabled = true;


        } else if (textarea.value.length === 0  ) {
            console.log("zero length");
            char.innerHTML = null;
            create_post_submit.disabled = true;
        }

        else {
            char.innerHTML = null;
            char.style.color = "black";
            create_post_submit.disabled = false;

        }

    });







});