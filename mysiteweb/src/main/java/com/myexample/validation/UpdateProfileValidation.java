package com.myexample.validation;


import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.myexample.model.Registration;

public class UpdateProfileValidation implements Validator 
{

	
	//String regex = "\\d+";
	String regex = "[0-9]+";
	String postalRegex = "\\d{6}";
	/*String str = "+123-9854875847";
	Pattern p = Pattern.compile(regex);
	Matcher m = p.matcher(str);
	if (m.matches())
	{
	   System.out.println("Country = " + m.group(3));
	   System.out.println("Data = " + m.group(4));
	}*/
	
	public boolean supports(Class<?> cl) {
		return Registration.class.isAssignableFrom(cl);
	}

	public void validate(Object command, Errors errors) 
	{
		Registration obj = (Registration)command;
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstName", "error.firstName", "Please enter the First Name.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastname", "error.lastname", "Please enter the Last Name. ");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "phone", "error.phone", "Please enter the Phone");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "country", "error.country", "Please enter the Country");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "state", "error.state", "Please enter the State");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pincode", "error.pincode", "Please enter the Pincode.");
        
        if(obj.getFirstName()!="" && obj.getFirstName().length()>25){
        	errors.rejectValue("firstName","error.firstName.invalid","First Name Max 25 chars accepted.");
        }else if(obj.getFirstName()!="" && !obj.getFirstName().matches("^[a-zA-Z]+$")){
        	errors.rejectValue("firstName","error.firstName.invalid","Please enter only alphabets.");
        }
       
        if(obj.getLastname()!="" && obj.getLastname().length()>25){
        	errors.rejectValue("lastname","error.lastname.invalid","Last Name Max 25 chars accepted.");
        }else if(obj.getFirstName()!="" && !obj.getLastname().matches("^[a-zA-Z]+$")){
        	errors.rejectValue("lastname","error.lastname.invalid","Please enter only alphabets.");
        }
        String phone = obj.getPhone();
        if((phone!="") && (phone.length()!=10)){
        	errors.rejectValue("phone","error.phone.invalid","Please enter a valid phone number.");
        }else if(phone!="" && !phone.matches(regex)){
        	errors.rejectValue("phone","error.phone.invalid","Please enter a valid phone number.");
        }
        
        if(obj.getCountry()!=null && obj.getCountry().length()>25){
        	errors.rejectValue("country","error.country.invalid","Country Max 25 chars accepted.");
        }
       
        if(obj.getState()!=null && obj.getState().length()>25){
        	errors.rejectValue("state","error.state.invalid","State Max 25 chars accepted.");
        }
        
       /* if(obj.getPincode()!="" && obj.getPincode().length()>4 &&  || !obj.getPincode().matches(postalRegex)){
        	errors.rejectValue("pincode","error.pincode.invalid","Please enter valid Pincode.");
        }*/
       
        
        
        String pincode = obj.getPincode();
        if((pincode!="") && (pincode.length()>10 || pincode.length()<4)){
        	errors.rejectValue("pincode","error.pincode.invalid","Please enter a valid pincode.");
        }else if(pincode!="" && !pincode.matches(regex)){
        	errors.rejectValue("pincode","error.pincode.invalid","Please enter a valid pincode.");
        }
		
	}
	
	

}
