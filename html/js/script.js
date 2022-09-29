$('document').ready(function() {
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case 'progress':
                draw(event.data)
                break;
            case 'cancel':
                cancel();
                break;
        }
    });
});

var ConfigJS = {
    //language: "es",

    progreessbar_color:"#BC94D4", //The color of the progressbar you can change it to any color you want
    progressbar_label_color:"", //The color of the label you can change it to any color you want
    progressbar_icon:"fa-solid fa-microchip", //The icon of the progressbar you can change it to any icon you want
    progressbar_icon_color:"#BC94D4", //The color of the icon you can change it to any color you want

    progressbar_background_error_color:"#f63737", //The color of the background when the progressbar is canceled
    progressbar_icon_error_color:"#f63737", //The color of the icon when the progressbar is canceled
    progressbar_text_error_color:"#f63737", //The color of the text when the progressbar is canceled

    progressbar_cancel_text:"¡CANCELADO!",
    progressbar_cancel_icon:"fa-solid fa-xmark",
};

/* WIP NEW UPDATE SOON
var TranslationJS = {
    "es" : {
        progressbar_cancel_text:"¡CANCELADO!",
        progressbar_cancel_icon:"fa-solid fa-xmark",
    },
    "en" : {
        progressbar_cancel_text:"Canceled!",
        progressbar_cancel_icon:"fa-solid fa-xmark",
    },
};
*/

let canvas = document.getElementById("canvas");
let ctx = canvas.getContext("2d");

let W = canvas.width;
let H = canvas.height;
let degrees = 0;
let new_degrees = 0;
let time = 0;
// // let color = "#eb5757";
let bgcolor = "rgba(0, 0, 0, 0.35)";
let bgcolor2 = "#f63737";
let animation_loop;
let animation_loop_full;
let cancel_timeout;

function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1) + min);
}

function init() {
    // Clear the canvas every time a chart is drawn
    ctx.clearRect(0,0,W,H);

    // Background 360 degree arc
    ctx.beginPath();
    ctx.strokeStyle = bgcolor;
    ctx.lineWidth = 28.5;
    ctx.arc(W / 2, H / 2, 100, 0, Math.PI * 2, false);
    ctx.stroke();

    // Angle in radians = angle in degrees * PI / 180
    let radians = degrees * Math.PI / 180;
    ctx.beginPath();
    ctx.strokeStyle = ConfigJS.progreessbar_color;
    ctx.lineCap = 'round';
    ctx.lineWidth = 25;
    ctx.arc(W / 2, H / 2, 100, 0 - 90 * Math.PI / 180, radians - 90 * Math.PI / 180, false);
    ctx.stroke();
}

let addition = 0
function draw(data) {
    ctx.clearRect(0,0,W,H);
    addition = 0;
    degrees = 0;
    if (ConfigJS.progressbar_label_color !== "") {
        $(".label").css("color", ConfigJS.progressbar_label_color);
    } else {
        $(".label").css("color", ConfigJS.progreessbar_color);
    }

    if (typeof cancel_timeout !== undefined) clearTimeout(cancel_timeout);
        
    $(".icon").html(`<i class=\"` + ConfigJS.progressbar_icon + `\" style=\"color:` + ConfigJS.progressbar_color + `\"></i>`);
    if (typeof animation_loop !== undefined) clearInterval(animation_loop);
    
    let duration = data.duration;
    if (ConfigJS.progressbar_icon_color !== "") {
        $(".icon").css("color", ConfigJS.progressbar_icon_color);
    }
    
    $(".label").text(data.label);
    $(".container").css("opacity", "0");
            
    if (data.icon !== null && data.icon !== undefined) { // Trying to use inv image that isn't there, no icon will show ${data.icon} \"${data.icon}\
        $(".icon").html(`<i style=\"color:` + ConfigJS.progressbar_color + `\" class=${data.icon}"> <img src= ${data.icon} onerror="this.onerror=null; this.remove();"> </i>`); 
    }
    
    $( ".container" ).animate({ opacity: 1 }, 500);
            
    degrees = 0;
    duration = duration * 0.25;
    new_degrees = 360;
    addition = (360 / duration);
    animation_loop = setInterval(animate_to, 1);
}

function animate_to() {
    if (degrees >= 360) {
        clearInterval(animation_loop);
        $( ".container" ).animate({
            opacity: 0,
        }, 500, function() {
            $.post('https://progressbar/FinishAction', JSON.stringify({
                })
            );
        });
        return;
    }
    init();
    degrees+=addition;
}

function cancel() {
    clearInterval(animation_loop);
    // addition = (new_degrees - degrees) / 50;
    animation_loop_full = setInterval(animate_to_full, 1);
    $(".label").text(ConfigJS.progressbar_cancel_text);
    $(".label").css("color", ConfigJS.progressbar_text_error_color);
    $(".icon").html("<i class=\"fa-solid fa-xmark\" style='color: " + ConfigJS.progressbar_icon_error_color + "'></i>");
    cancel_timeout = setTimeout(function () {
        clearInterval(animation_loop_full);
        $( ".container" ).animate({
            opacity: 0,
        }, 500, function() {
            $.post('https://progressbar/CancelAction', JSON.stringify({}));
        });
    }, 1000);
}

function animate_to_full() {
    init();
    // degrees+=addition;
}