//login창 띄우는 js코드  

$(document).ready(function(){
	$('input[type="submit"]').mousedown(function(){
	  $(this).css('background', '#ecf0f1');
	});
	$('input[type="submit"]').mouseup(function(){
	  $(this).css('background', '#ecf0f1');
	});
	
	$('#loginText').toggle(function(){
		$('.login').css("display","block");
		$('.login').fadeToggle('slow');
		$(this).toggleClass('pink');
	},function(){
		$('.login').css("display","none");
		$('.login').fadeToggle('slow');
		$(this).toggleClass('pink');
	});
});

$(document).mouseup(function (e)
{
    var container = $(".login");

    if (!container.is(e.target) // if the target of the click isn't the container…
        && container.has(e.target).length === 0) // … nor a descendant of the container
    {
        container.hide();
        $('#loginform').removeClass('pink');
    }
});