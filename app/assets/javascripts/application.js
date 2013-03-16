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



