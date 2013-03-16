// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .


$(function() {
	if($(".pView").length !== 0)
	{
		resize_pView(null);
		$(window).resize(resize_pView);
		$("#textbox").keydown(function(e) {
			if(e.keyCode == 13 && $("#textbox").val().trim() !== "")
			{
				e.preventDefault();
				paragraphCreated();
			}
			else if(e.keyCode == 8 && $("#textbox").val() === "")
			{
				e.preventDefault();
				paragraphDeleted();
			}
		});
	}
});


function resize_pView(e)
{
	var occupied = $(".navbar").height() + $(".taContainer").height();
	var newSize = $(document).height() - occupied - 30;
	$(".pView").height(newSize);
}

function generateParagraph(p)
{
	var pDiv = $("<div />",
			{
				class: "row-fluid"
			});

	var dateDiv = $("<div />",
	{
		class: "span1 dateMark"
	});

	var textDiv = $("<div />",
	{
		class: "span11 pText"
	});

	dateDiv.text(p.timestamp.getHours() + ":" + p.timestamp.getMinutes());
	textDiv.html(p.text);

	dateDiv.appendTo(pDiv);
	textDiv.appendTo(pDiv);

	return pDiv;
}

function paragraphCreated()
{
	var text = $("#textbox").val();
	$("#textbox").val("");
	var p = {};
	p.text = text;
	p.timestamp = new Date();

	generateParagraph(p).appendTo('.pView');
	$(".pView").animate(
	{
		scrollTop :$(".pView").height()
	});

	$.post("/lecture/addParagraph", p)
		.fail(function() { console.log("Crap."); });
}

function paragraphDeleted()
{
	var last = $(".pView .row-fluid").last();

	if(typeof last != 'undefined')
	{
		var text = last.children(".pText").html();
		$("#textbox").val(text);
		last.remove();
	}
}
