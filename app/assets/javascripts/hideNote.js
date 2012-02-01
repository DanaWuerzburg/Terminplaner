/**
 * Created by JetBrains RubyMine.
 * User: Bine
 * Date: 21.12.11
 * Time: 16:27
 * To change this template use File | Settings | File Templates.
 */


function FadeContent(d) {
	if (d.length <1 ) {return;}
    if(document.getElementById(d).style.display == "none") { document.getElementById(d).style.display = "block"; }
	else { document.getElementById(d).style.display = "none";
    start = setTimeout("action('"+d+"')", 3000);}

    }