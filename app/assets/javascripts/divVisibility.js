function DivEinAusblenden(divName){

 if(document.getElementById(divName)){
    /*document.getElementById(divName).style.display = (document.getElementById(divName).style.display == 'none') ? 'block' : 'none';
      */
    document.getElementById("navbar").className = (document.getElementById("navbar").className == '') ? 'noborder' : '';
    document.getElementById(divName).className = (document.getElementById(divName).className != '') ? '' : 'visible';
    if(document.getElementById(divName).className == 'visible'){
        var checkedGroups = new Array();
        for (i=0;i<=document.getElementsByName("group").length;i++){
            if(document.getElementsByName("group")[i].checked == "checked"){
                checkedGroups[i] = document.getElementsByName("group")[i].value;
            }
        }

    }
}
}