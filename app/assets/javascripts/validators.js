
function validateForm(formName)
{


    if(formName == "new_appointment"){
        var frmvalidator  = new Validator(formName);
        frmvalidator.EnableOnPageErrorDisplaySingleBox();
        frmvalidator.EnableMsgsTogether();

        frmvalidator.addValidation("appointment_start_at","req","Please select a Start Date for your Appointment");
        frmvalidator.addValidation("appointment_end_at","req","Please select an End Date for your Appointment");
        frmvalidator.addValidation("appointment_note","req","Please enter a Note for your Appointment");
    }
    if(formName == "new_group"){
        var frmvalidator2  = new Validator(formName);
        frmvalidator2.EnableOnPageErrorDisplaySingleBox();
        frmvalidator2.EnableMsgsTogether();

        frmvalidator2.addValidation("group_name","req","Please select a Name for your new Group");
    }
    if(formName == "new_user"){
        var frmvalidator3  = new Validator(formName);
        frmvalidator3.EnableOnPageErrorDisplaySingleBox();
        frmvalidator3.EnableMsgsTogether();

        frmvalidator3.addValidation("user_login","req","Please select a Username");
        frmvalidator3.addValidation("user_email","req","Please select an Email");
        frmvalidator3.addValidation("user_email","email","Please check whether your Email is valid");
        frmvalidator3.addValidation("user_password","req","Please select a Password");
        frmvalidator3.addValidation("user_password_confirmation","req","Please confirm your Password");
        frmvalidator3.addValidation("user_password_confirmation","eqelmnt=user_password","Your Password Confirmation doesn't match.");

    }

}