
function validateForm(formName)
{
 var frmvalidator  = new Validator(formName);
 frmvalidator.EnableOnPageErrorDisplaySingleBox();
 frmvalidator.EnableMsgsTogether();

    if(formName == "new_appointment" || "edit_appointment"){
        frmvalidator.addValidation("appointment_start_at","req","Please select a Start Date for your Appointment");
        frmvalidator.addValidation("appointment_end_at","req","Please select an End Date for your Appointment");
        frmvalidator.addValidation("appointment_end_at","gt","Please select an End Date greater than your Start Date");
        frmvalidator.addValidation("appointment_note","req","Please enter a Note for your Appointment");
    }



}