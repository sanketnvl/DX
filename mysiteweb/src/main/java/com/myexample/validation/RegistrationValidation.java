package com.myexample.validation;

import java.util.regex.Pattern;

import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.myexample.model.Registration;

public class RegistrationValidation implements Validator{

	private static final String SIMPLE_EMAIL_REGEX = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	public boolean supports(Class<?> cl) {
		return Registration.class.isAssignableFrom(cl);
	}

	public void validate(Object command, Errors errors) 
	{
		Registration obj = (Registration)command;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstName", "error.firstName", "Name is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastname", "error.lastname", "Last Name is required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "error.email", "Email is required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "error.password", "Password is required.");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmpassword", "error.confirmpassword", "Confirm Password is required.");
        
        if(obj.getFirstName()!=null && obj.getFirstName().length()>25){
        	errors.rejectValue("firstName","error.firstName.invalid","Max 25 chars accepted.");
        }else if(!obj.getFirstName().matches("^[a-zA-Z]+$")){
        	errors.rejectValue("firstName","error.firstName.invalid","Alphabets accepted.");
        }
        
        
        if(obj.getLastname()!=null && obj.getLastname().length()>25){
        	errors.rejectValue("lastname","error.lastname.invalid","Max 25 chars accepted.");
        }else if(!obj.getLastname().matches("^[a-zA-Z]+$")){
        	errors.rejectValue("lastname","error.lastname.invalid","Alphabets accepted.");
        }
        
        
        if(obj.getEmail()!=null && obj.getEmail().length()>50){
        	errors.rejectValue("email","error.email.invalid","Max 50 chars accepted.");
        }
        if(obj.getPassword()!=null && obj.getPassword().length()>25 || obj.getPassword().length()<8){
        	errors.rejectValue("password","error.password.invalid","Password between 8 to 25 chars accepted.");
        }
        if(obj.getConfirmpassword()!=null && obj.getConfirmpassword().length()>25){
        	errors.rejectValue("confirmpassword","error.confirmpassword.invalid","Max 25 chars accepted.");
        }

        
        if (StringUtils.hasText(obj.getEmail()) && !Pattern.matches(SIMPLE_EMAIL_REGEX,obj.getEmail().toUpperCase())) {
            errors.rejectValue("email","error.email.invalid","Please enter a valid email address.");
         }
        
        if (!obj.getPassword().equals(obj.getConfirmpassword())) {
            errors.rejectValue("password","error.password.invalid","Confirm password must be same.");
         }
		
	}


}
