// Next/previous controls
function plusSlides(n) {
  showSlides((slideIndex += n));
}

// Thumbnail image controls
function currentSlide(n) {
  showSlides((slideIndex = n));
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  // var slides = document.getElementById(window.pn).querySelectorAll(".mySlides");
  var dots = document.getElementsByClassName("demo");
  // var dots = document.getElementById(window.pn).querySelectorAll(".demo");
  // var captionText = document.getElementsByClassName("caption");
  if (n > slides.length) {
    slideIndex = 1;
  }
  if (n < 1) {
    slideIndex = slides.length;
  }
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex - 1].style.display = "block";
  dots[slideIndex - 1].className += " active";
  // captionText[0].innerHTML = dots[slideIndex - 1].alt;
  displayCaps(window.pn,slideIndex); 
  displayNoComments(window.pn,n);
  
  var c = document.getElementById("commentsContainer")
  c.style.display = "none";
  var cc = document.getElementById("caption-container")
  cc.style.border= "2px solid var(--color1)";
  var b = document.getElementById("commentsButton")
  b.innerHTML = '<i class="fa fa-caret-down"></i> View/Leave comments'
  window.commentState = 0;

  // store array data to the session storage
  var st = [window.pn,'Pics',slideIndex,0,'about'];
  sessionStorage.setItem("state2",  JSON.stringify(st));
}

function openTab(evt, tabName) {
  // Declare all variables
  var i, tabcontent, tablinks;

  // Get all elements with class="tabcontent" and hide them
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Get all elements with class="tablinks" and remove the class "active"
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }

  // Show the current tab, and add an "active" class to the button that opened the tab
  document
    .getElementById(window.pn)
    .querySelectorAll(".".concat(tabName))[0].style.display = "block";
  
  document.getElementById(tabName.concat("-bt")).className += " active";

     var st = sessionStorage.getItem("state2");
     var dst = JSON.parse(st); 
     var nst = [dst[0],tabName,dst[2],dst[3],dst[4]];
     sessionStorage.setItem("state2",  JSON.stringify(nst));
}

function openAbout() {
  var i, tabcontent, tab, settings;

  // Get all elements with class="tabcontent" and hide them
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Get all elements with class="tab" and hide them
  tab = document.getElementById("normaltabs");
  tab.style.display = "none";

  settings = document.getElementById("abouttabs");
  settings.style.display = "block";

  openATab(event, 'about');
}

function hideAbout() {
  var tab, settings;
  // Get all elements with class="tab" and hide them
  tab = document.getElementById("normaltabs");
  tab.style.display = "block";

  settings = document.getElementById("abouttabs");
  settings.style.display = "none";
}

function openATab(evt, tabName) {
  // Declare all variables
  var i, tabcontent, tablinks;

  // Get all elements with class="tabcontent" and hide them
  tabcontent = document.getElementsByClassName("atabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Get all elements with class="tablinks" and remove the class "active"
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }

  // Show the current tab, and add an "active" class to the button that opened the tab
  var _url = tabName.concat(".html");
  $.ajax({
      url : _url,
      type : 'post',
      success: function(data) {
       $('#DIVID').html(data);
      },
      error: function() {
       $('#DIVID').text('An error occurred');
      }
  });

  document.getElementById(tabName.concat("-bt")).className += " active";
  
  var st = [window.pn,'Pics',1,1,tabName]
  sessionStorage.setItem("state2",  JSON.stringify(st));
}

document.getElementById("dropdown").onmouseover = function () {
  var tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }
  var atabcontent = document.getElementsByClassName("atabcontent");
  for (i = 0; i < atabcontent.length; i++) {
    atabcontent[i].style.display = "none";
  }
  var tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].style.display = "none";
  }
  var dropcontent = document.getElementById("dropdown-content");
    dropcontent.style.display = "flex";
    dropcontent.style.flex ="1";
    dropcontent.style.flexFlow = "column nowrap";
}

function timeRiding() {
    var start = new Date(2019, 0, 13, 0, 0, 0, 0);
    var now = new Date(); 
    var diff = Math.round((now - start)/604800000);
    document.getElementById("timeriding").innerHTML = diff;
}

function km2miles(inSpan,outSpan) {
    var km = document.getElementById(inSpan).innerHTML;
    var miles = Math.round(km/(1.609*10))*10;
    document.getElementById(outSpan).innerHTML = miles;
}

function m2feet(inSpan,outSpan) {
    var m = document.getElementById(inSpan).innerHTML;
    var feet = Math.round(m*3.281/10)*10;
    document.getElementById(outSpan).innerHTML = feet;
}

function mkTitle(pn){
    var t = document.getElementById("title");
    var bt = document.getElementById("b0.".concat(pn)).cloneNode(true);
    bt.classList.remove("pagelinks");
    t.innerHTML = "";
    t.appendChild(bt);
}

function btnclick(pn,P,si){
    var _url = "pages/page".concat(pn).concat(".html");
    $.ajax({
        url : _url,
        type : 'post',
        success: function(data) {
         $('#DIVID').html(data);
         hideAbout();

         var st = [pn,P,si,0,'about'];
         sessionStorage.setItem("state2",  JSON.stringify(st));

         currentSlide(si);
         openTab(event,P);
        },
        error: function() {
         $('#DIVID').text('An error occurred');
        }
    });
    document.getElementById("dropdown-content").style.display = "none";
    var tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
      tablinks[i].style.display = "inline-block";

    mkTitle(pn);
    }
    window.pn = pn;
}

document.onkeydown = function(event) {
      switch (event.keyCode) {
         case 37:
              event.preventDefault();

              var p = document.getElementById(window.pn).querySelectorAll(".Pics")[0]
              if (window.getComputedStyle(p).display === "block"){
                            plusSlides(-1);
              }
            break;
         
         case 39:
              event.preventDefault();
              
              var p = document.getElementById(window.pn).querySelectorAll(".Pics")[0]
              if (window.getComputedStyle(p).display === "block"){
                            plusSlides(1);
              }
            break;
         
      }
};

function convertDates() {
    var times = document.getElementsByClassName("Time");
    for (i = 0; i<times.length; i++) {
        var t = times[i].innerHTML.split(/[- :]/);
        var d = new Date(Date.UTC(t[0], t[1]-1, t[2], t[3], t[4], t[5]));
        console.log(d);
        var m = moment.utc(d, "YYYYMMDD").local().fromNow();
        times[i].innerHTML = "[".concat(m).concat("]");
    }
}

function displayComments () {
    var st = sessionStorage.getItem("state2");
    if (st) {
        dst = JSON.parse(st);
        window.si = dst[2];
    }
    $.ajax({    //create an ajax request to display.php
      type: "GET",
      url: "comment_list.php",             
      dataType: "html",   //expect html to be returned                
      data: {storyNo: window.pn, picNo: window.si},
      success: function(response){                    
          $("#comment_listing").html(response); 
          //alert(response);
      }
    }).done(function() {
        convertDates()
    });
}

function displayCaps (pn,si) {
    $.ajax({    //create an ajax request to display.php
      type: "GET",
      url: "display-cap.php",             
      dataType: "html",   //expect html to be returned                
      data: {storyNo: pn, picNo: si},
      success: function(response){                    
          $("#caption").html(response); 
          //alert(response);
      }
    });
}

function displayWords (pn) {
    $.ajax({    //create an ajax request to display.php
      type: "GET",
      url: "display-words.php",             
      dataType: "html",   //expect html to be returned                
      data: {storyNo: pn},
      success: function(response){                    
          $("#Words").html(response); 
          //alert(response);
      }
    });
}

function displayNoComments (pn,si) {
    $.ajax({    //create an ajax request to display.php
      type: "GET",
      url: "numComments.php",             
      dataType: "html",   //expect html to be returned                
      data: {storyNo: pn, picNo: si},
      success: function(response){                    
          $("#noComs").html('<i class="fa fa-comments"></i> '.concat(response).concat(" comments")); 
      }
    });
}

function warning (a) {
    if (a == "name") {
        var w = document.getElementById("warning");
        var s = document.getElementById("submit");
        var b = document.getElementById("ok");
        var n = document.getElementById("name");
        var nl = document.getElementById("nameLabel");
        s.style.display = "none";
        w.style.display ="block";
        b.style.display ="block";
        n.style.display ="none";
        nl.style.display ="none";
        w.innerHTML = "!! You must enter a name !!";
    }
    else if (a == "comment") {
        var w = document.getElementById("warning");
        var s = document.getElementById("submit");
        var b = document.getElementById("ok");
        var n = document.getElementById("name");
        var nl = document.getElementById("nameLabel");
        s.style.display = "none";
        w.style.display ="block";
        b.style.display ="block";
        n.style.display ="none";
        nl.style.display ="none";
        w.innerHTML = "!! You must enter a comment !!";
    }
}

function ok() {
        var w = document.getElementById("warning");
        var s = document.getElementById("submit");
        var b = document.getElementById("ok");
        var n = document.getElementById("name");
        var nl = document.getElementById("nameLabel");
        s.style.display = "block";
        w.style.display ="none";
        b.style.display ="none";
        n.style.display ="inline-block";
        nl.style.display ="inline-block";
}
