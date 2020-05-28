<!DOCTYPE html>

<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>< 20 kmph</title>
        <link rel="icon" type="image/png" href="favicon.ico">
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="leaflet.css" />
        <script src=color-scripts.js></script>
        <script src="yall.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function() {
              yall({
                observeChanges: true
              });
            });
        </script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>

    <body>
        <div id=mainFrame>
            <div id="header">
                <?php include 'logo.php';?>
            </div>
            <div id="subheader">
                <div id="dropdown">
                    <div class="menuIcon">
                        <i class="fa fa-bars"></i>
                    </div>
                </div>
                <div id="title" class="titleButton"></div>
                <button class="dropbtnFill" onclick="openAbout()"><i class="fa fa-info-circle"></i></button>
            </div>
            <!-- Tab links -->
            <div id="normaltabs" class="tab">
                <button class="tablinks" onclick="openTab(event, 'Pics')" id="Pics-bt">Pictures</button>
                <button class="tablinks" onclick="openTab(event, 'Words')" id="Words-bt">Words</button>
            </div>
            <div id="abouttabs" class="tab" style="display: none">
                <button class="tablinks" onclick="openATab(event, 'about')" id="about-bt">About</button>
                <button class="tablinks" onclick="openATab(event, 'stats')" id="stats-bt">Stats</button>
                <button class="tablinks" onclick="openATab(event, 'map')" id="map-bt">Map</button>
                <button class="tablinks" onclick="openATab(event, 'cshemes')" id="cshemes-bt">Colours</button>
            </div>
            <div id="dropdown-content">
                <button class="pagelinks" onclick="btnclick('29','Pics',1)" id="b0.29">#29: Cuenca to Guayaquil</button></br>
                <button class="pagelinks" onclick="btnclick('28','Pics',1)" id="b0.28">#28: San Ignacio to Cuenca</button></br>
                <button class="pagelinks" onclick="btnclick('27','Pics',1)" id="b0.27">#27: Moyobamba to San Ignacio</button></br>
                <button class="pagelinks" onclick="btnclick('26','Pics',1)" id="b0.26">#26: (Mostly) Flowers around Moyobamba</button></br>
                <button class="pagelinks" onclick="btnclick('25','Pics',1)" id="b0.25">#25: Hu&aacute;nuco to Moyobamba</button></br>
                <button class="pagelinks" onclick="btnclick('24','Pics',1)" id="b0.24">#25: Lima to Hu&aacute;nuco</button></br>
                <button class="pagelinks" onclick="btnclick('23','Pics',1)" id="b0.23">#24: Lima</button></br>
                <button class="pagelinks" onclick="btnclick('22','Pics',1)" id="b0.22">#23: Laraos to Lima</button></br>
                <button class="pagelinks" onclick="btnclick('21','Pics',1)" id="b0.21">#22: Huancavelica to Laraos</button></br>
                <button class="pagelinks" onclick="btnclick('20','Pics',1)" id="b0.20">#21: Vilcas to Huancavelica</button></br>
                <button class="pagelinks" onclick="btnclick('19','Pics',1)" id="b0.19">#20: Antabamba to Vilcas Huaman</button></br>
                <button class="pagelinks" onclick="btnclick('18','Pics',1)" id="b0.18">#19: Cotahuasi to Antabamba</button></br>
                <button class="pagelinks" onclick="btnclick('17','Pics',1)" id="b0.17">#18: Cotahuasi Canyon</button></br>
                <button class="pagelinks" onclick="btnclick('16','Pics',1)" id="b0.16">#17: Arequipa to Cotahuasi</button></br>
                <button class="pagelinks" onclick="btnclick('15','Pics',1)" id="b0.15">#16: Around Arequipa</button></br>
                <button class="pagelinks" onclick="btnclick('14','Pics',1)" id="b0.14">#15: Copacabana to Arequipa</button></br>
                <button class="pagelinks" onclick="btnclick('13','Pics',1)" id="b0.13">#14: La Paz to Copacabana</button></br>
                <button class="pagelinks" onclick="btnclick('12','Pics',1)" id="b0.12">#13: Coroico to La Paz (up the death road)</button></br>
                <button class="pagelinks" onclick="btnclick('11','Pics',1)" id="b0.11">#12: Oruro to Coroico</button></br>
                <button class="pagelinks" onclick="btnclick('10','Pics',1)" id="b0.10">#11: Uyuni to Oruro</button></br>
                <button class="pagelinks" onclick="btnclick('9','Pics',1)" id="b0.9">#10: San Pedro to Uyuni</button></br>
                <button class="pagelinks" onclick="btnclick('8','Pics',1)" id="b0.8">#9: Around San Pedro de Atacama</button></br>
                <button class="pagelinks" onclick="btnclick('7','Pics',1)" id="b0.7">#8: Antofagasta to San Pedro de Atacama</button></br>
                <button class="pagelinks" onclick="btnclick('6','Pics',1)" id="b0.6">#7: Atacama to Antofagasta</button></br>
                <button class="pagelinks" onclick="btnclick('5','Pics',1)" id="b0.5">#6: Punta Choros to the Atacama</button></br>
                <button class="pagelinks" onclick="btnclick('4','Pics',1)" id="b0.4">#5: Santiago to Punta Choros</button></br>
                <button class="pagelinks" onclick="btnclick('3','Pics',1)" id="b0.3">#4: From the fjords to Santiago</button></br>
                <button class="pagelinks" onclick="btnclick('2','Pics',1)" id="b0.2">#3: End of the world to the fjords</button></br>
                <button class="pagelinks" onclick="btnclick('1','Pics',1)" id="b0.1">#2: To the end of the world</button></br>
                <button class="pagelinks" onclick="btnclick('0','Pics',1)" id="b0.0">#1: Devon to Patagonia</button>
            </div>

            <div id="DIVID">
            </div>
        </div>
    </body>

    <script src="scripts.js"></script>
    <script>
        var st = sessionStorage.getItem("state2");
        var un = sessionStorage.getItem("un");
        if (st && un == 29) {
            dst = JSON.parse(st);
            console.log(dst);
            window.pn = dst[0];
            window.P = dst[1];
            window.si = dst[2];
            window.A = dst[3];
            window.Ap = dst[4];
            if (window.A == 0) {
                btnclick(window.pn,window.P,window.si);
            }
            else {
                openAbout();
                mkTitle(window.pn);
                openATab(event,window.Ap);
            }
        }
        else {
            window.pn = 29;
            window.P = 'Pics';
            window.si = 1;
            window.A = 0;
            window.Ap = 'about';
            btnclick(window.pn,window.P,window.si);
            sessionStorage.setItem("un",29);
            }
    </script>
</html>
