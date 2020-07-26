window.commentState = 0;
function toggleComments() {
    if (window.commentState === 0) {
        var c = document.getElementById("commentsContainer")
        c.style.display = "block";
        var cc = document.getElementById("caption-container")
        cc.style.borderBottom = "0px solid";
        var b = document.getElementById("commentsButton")
        b.innerHTML = '<i class="fa fa-caret-up"></i> Hide comments'
        displayComments();
        window.commentState = 1;
    }
    else {
        var c = document.getElementById("commentsContainer")
        c.style.display = "none";
        var cc = document.getElementById("caption-container")
        cc.style.border= "2px solid var(--color1)";
        var b = document.getElementById("commentsButton")
        b.innerHTML = '<i class="fa fa-caret-down"></i> View/Leave comments'
        window.commentState = 0;
    }
}

$('#submit').click(function() {
    var val1 = $('#name').val();
    var val2 = $('#comment').val();
    var tval1=$.trim(val1);
    var tval2=$.trim(val2);
    var st = sessionStorage.getItem("state2");
    if (st) {
        dst = JSON.parse(st);
        window.si = dst[2];
    }
    if(tval1.length>0 && tval2.length>0) {
        $.ajax({
            type: 'POST',
            url: 'save_comment.php',
            data: { storyNo: window.pn, picNo: window.si, name: val1, comment: val2.replace(/\n\r?/g, '<br />') },
                success: function() {
                    document.getElementById('name').value = ''
                    document.getElementById('comment').value = ''
                }
        }).done(function(){
            displayNoComments(window.pn,window.si);
        });
        }
        else if (tval1.length>0) {
            warning("comment");
        }
        else {
            warning("name");
        }
        displayComments();
});

function getCaptions () {
    var dots = document.getElementsByClassName("demo");
    for (i = 0 ; i < dots.length; i++) {
        var e = dots[i].alt.replace(/\n\r?/g,'').replace(/\s+/g,' ').trim();
        $.ajax({
            type: 'POST',
            url: 'save_cap.php',
            data: { storyNo: window.pn, picNo: i+1, cap: e },
            success: function() {
                //console.log("caption #".concat(i).concat(" saved!"))
            }
            });
    }
}

function getWords () {
    var w = document.getElementsByClassName("Words");
    var e = w[0].innerHTML.replace(/\n\r?/g,'').replace(/\s+/g,' ').trim();
        $.ajax({
            type: 'POST',
            url: 'save_words.php',
            data: { storyNo: window.pn, words: e },
            success: function() {
                //console.log("words saved!")
            }
            });
    }
displayWords (window.pn);
