#!/bin/bash

id=$1
pf=$"pics/$id"
npf=$(ls $pf | wc -l)
n=$(($npf/2))

cat >pages/page$id.html <<EOL
<div id="$id" class="pagecontent">
    <div class="tabcontent Pics">
        <div class="container4Slides">
            <div class="wrapper4slides">
EOL

for i in $(seq $n); do
cat >>pages/page$id.html <<EOL
                <div class="mySlides">
                    <img class="lazy" src="placeholder.png" data-src="$pf/$i.jpg" style="width:100%">
                </div>
EOL
done

cat >>pages/page$id.html <<EOL
                <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
                <a class="next" onclick="plusSlides(1)">&#10095;</a>
            </div>

            <div id="caption-container">
                <div id="caption"></div>
                <div style="display: flex">
                <div id="noComs"></div>
                <button id="commentsButton" onclick="toggleComments()"><i class="fa fa-caret-down"></i> View/Leave comments </button>
                </div>
            </div>
            <div id=commentsContainer>
                <div class="inputs">
                    <div id="nameinputs">
                        <span id="nameLabel">Name: </span>
                        <input id="name" type="text" class="name" placeholder="Your name...">
                        <button id="ok" onclick="ok()">OK</button>
                        <div id="warning"></div>
                        <button id="submit">Submit</button>
                    </div>
                    <textarea rows="2" id="comment" class="comment" placeholder="Write your comment..."></textarea>
                </div>
                <div id="comment_listing"></div>
            </div>
            <div id="thumbContainer">
EOL

nr=$(($n/6))
rem=$(($n%6))
c=0

for i in $(seq $nr); do
cat >>pages/page$id.html <<EOL
                <div class="rowP">
                    <div class="columnP">
                        <img class="demo cursor lazy" src="placeholder.png" data-src="$pf/$((1+$c)).thumb.jpg" style="width:100%; height:100%" onclick="currentSlide($((1+$c)))" alt="
                                                ">
                    </div>
                    <div class="columnP">
                        <img class="demo cursor lazy" src="placeholder.png" data-src="$pf/$((2+$c)).thumb.jpg" style="width:100%; height:100%" onclick="currentSlide($((2+$c)))" alt="
                                                ">
                    </div>
                    <div class="columnP">
                       <img class="demo cursor lazy" src="placeholder.png" data-src="$pf/$((3+$c)).thumb.jpg" style="width:100%; height:100%" onclick="currentSlide($((3+$c)))" alt="
                                                ">
                    </div>
                    <div class="columnP">
                        <img class="demo cursor lazy" src="placeholder.png" data-src="$pf/$((4+$c)).thumb.jpg" style="width:100%; height:100%" onclick="currentSlide($((4+$c)))" alt="
                                                ">
                    </div>
                    <div class="columnP">
                        <img class="demo cursor lazy" src="placeholder.png" data-src="$pf/$((5+$c)).thumb.jpg" style="width:100%; height:100%" onclick="currentSlide($((5+$c)))" alt="
                                                ">
                    </div>
                    <div class="columnP">
                        <img class="demo cursor lazy" src="placeholder.png" data-src="$pf/$((6+$c)).thumb.jpg" style="width:100%; height:100%" onclick="currentSlide($((6+$c)))" alt="
                                                ">
                    </div>
                </div>
EOL
c=$(($c+6))
done

if [ $rem != 0 ]; then
cat >>pages/page$id.html <<EOL
                <div class="rowP">
EOL
for i in $(seq $rem); do
cat >>pages/page$id.html <<EOL
                    <div class="columnP">
                        <img class="demo cursor lazy" src="placeholder.png" data-src="$pf/$(($i+$c)).thumb.jpg" style="width:100%; height:100%" onclick="currentSlide($(($i+$c)))" alt="
                                                ">
                    </div>
EOL
done
cat >>pages/page$id.html <<EOL
                </div>
EOL
fi

cat >>pages/page$id.html <<EOL
            </div>
        </div> 
    </div>

    <div id="Words" class="tabcontent Words"></div>
</div>
<script type="text/javascript" src="moment.min.js"></script>
<script type="text/javascript" src="moment-tz.min.js"></script>
<script type="text/javascript" src="pagescript.js"></script>
EOL
