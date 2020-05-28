function recallCol() {
    var s = localStorage.getItem("cscheme");
    changeCols(s);
}

function changeCols(s) {
  var css = document.documentElement.style;
  var c1 = getComputedStyle(document.documentElement).getPropertyValue(
    "--color1-".concat(s)
  );
  var c2 = getComputedStyle(document.documentElement).getPropertyValue(
    "--color2-".concat(s)
  );
  var c3 = getComputedStyle(document.documentElement).getPropertyValue(
    "--color3-".concat(s)
  );
  var c4 = getComputedStyle(document.documentElement).getPropertyValue(
    "--color4-".concat(s)
  );

  css.setProperty("--color1", c1);
  css.setProperty("--color2", c2);
  css.setProperty("--color3", c3);
  css.setProperty("--color4", c4);

  localStorage.setItem("cscheme", s);
}

recallCol();
