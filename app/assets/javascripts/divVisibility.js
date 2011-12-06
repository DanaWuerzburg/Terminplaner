function DivEinAusblenden(divName){

 if(document.getElementById(divName)){
    /*document.getElementById(divName).style.display = (document.getElementById(divName).style.display == 'none') ? 'block' : 'none';
      */
    document.getElementById("navbar").className = (document.getElementById("navbar").className == '') ? 'noborder' : '';
    document.getElementById(divName).className = (document.getElementById(divName).className != '') ? '' : 'visible';

}
}