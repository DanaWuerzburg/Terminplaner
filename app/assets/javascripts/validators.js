
function validateForm(formName)
{


    if(formName == "new_appointment"){
        var frmvalidator  = new Validator(formName);
        frmvalidator.EnableOnPageErrorDisplaySingleBox();
        frmvalidator.EnableMsgsTogether();
        frmvalidator.addValidation("appointment_start_at","req","Please select a Start Date for your Appointment");
        frmvalidator.addValidation("appointment_end_at","req","Please select an End Date for your Appointment");
        frmvalidator.addValidation("appointment_end_at","gt","Please select an End Date greater than your Start Date");
        frmvalidator.addValidation("appointment_note","req","Please enter a Note for your Appointment");
    }
    if(formName == "new_group"){
        var frmvalidator2  = new Validator(formName);
        frmvalidator2.EnableOnPageErrorDisplaySingleBox();
        frmvalidator2.EnableMsgsTogether();
        frmvalidator2.addValidation("group_name","req","Please select a Name for your new Group");
    }


}