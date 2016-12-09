package com.myexample.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.myexample.model.ResetPassword;



public class ResetPasswordValidator implements Validator {

	@Override
	public boolean supports(Class<?> arg0) {

		return ResetPassword.class.isAssignableFrom(arg0);
	}

	@Override
	public void validate(Object object, Errors errors) {
		ResetPassword obj = (ResetPassword)object;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "error.password", "Password is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmpassword", "error.confirmpassword", "Confirm Password is required.");
		
		
        if(obj.getPassword()!=null && obj.getPassword().length()>25 || obj.getPassword().length()<8){
        	errors.rejectValue("password","error.password.invalid","Your password must be at least 8 characters long.");
        }
        if(obj.getConfirmpassword()!=null && obj.getConfirmpassword().length()>25){
        	errors.rejectValue("confirmpassword","error.confirmpassword.invalid","Max 25 chars accepted.");
        }

		
		if(!obj.getPassword().equals(obj.getConfirmpassword())){
			 errors.rejectValue("password","error.password.invalid","Confirm password must be same.");
		}
		
	}

}
