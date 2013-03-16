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

function DocumentViewer(container){

	this.supercontainer = container;
	this.documents = [];
	this.activeDocument = null;
	this.canvasWidth = container.width() * 0.8;

	this.switchTo =  function (elementIndex){

	}

	this.createPdfContainer = function (pdf){

		var numPages = pdf.numPages;
		var container = $("<div />",{
			class: "pdf-container"
		}).appendTo(this.supercontainer);
		
		for (var i = 1; i <= numPages; i++) {

			pdf.getPage(i).then(function(page){

				var canvas = $("<canvas />",{
					class: "pdf-canvas"
				}).appendTo(container);

				var viewport = page.getViewport(0.37);

				canvas.width (this.canvasWidth);
				var scale = canvas.width()/viewport.width;

				canvas.height (viewport.height * scale);

				

				//viewport = page.getViewport(scale);				
				
				var context = canvas[0].getContext('2d');

				//
				// Render PDF page into canvas context
				//
				page.render({canvasContext: context, viewport: viewport});
				//page.render(context);

/*
				var canvas = $("<canvas />",{
					class: "pdf-canvas"
				}).appendTo(container);

				

				page.render(canvas[0].getContext('2d'));
				*/
			})

		};


	}

	this.loadPdf = function (documentName){

		var loadedDocument = {};
		loadedDocument.documentName = documentName;

		PDFJS.disableWorker = true;

		PDFJS.getDocument(documentName).then(function getPdfHelloWorld(pdf) {
		//PDFJS.getPdf(documentName, function (data) {

			//loadedDocument.pdf = new PDFJS.PDFDoc(data);
			loadedDocument.pdf = pdf;
			loadedDocument.conatiner = this.createPdfContainer(loadedDocument.pdf);

		});
	}

	return this;

}

$(function(){
	var docView = DocumentViewer($("#sidebar-documents-viewer"));
	docView.loadPdf("/pdfs/example.pdf");
});


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
	var occupied = 22 + $(".taContainer").height();
	var newSize = $(document).height() - occupied;
	$(".pView").height(newSize-30);
	$("#sidebar-documents-viewer").height(newSize);
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

	dateDiv.text(pad(p.timestamp.getHours(),2) + ":" + pad(p.timestamp.getMinutes(),2));
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

	$.post("/lecture/addParagraph", {
		id: noteId,
		paragraph: p
	})
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

function pad(num, size) {
	var s = num+"";
	while (s.length < size) s = "0" + s;
	return s;
}

function loadNote(id, where)
{
	var divName = "#note" + where;
	$.get("/note/json/" + id)
		.done(function(data) {
			for(var p in data.paragraphs)
				generateParagraph(p).appendTo(divName);

			$(divName).animate(	{
				scrollTop : $(divName).height()
			});
		});
}

function noteViewReady() {
	if(otherNotes.length > 0)
	{
		var id = otherNotes[0];
		loadNote(id, "B");
	}

	$(".dropitem").click(function (e) {
		var clicked = $(e.target);
		var target = clicked.attr("data-where");
		var note = clicked.attr("data-id");
		$("#dd" + target).text(clicked.text());
		loadNote(note, target);
	});
}
