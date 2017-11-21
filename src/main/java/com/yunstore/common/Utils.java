package com.yunstore.common;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Utils {
	
	final static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	public static final String dateToString(Date date) {
		
		if(date != null) {
			return sdf.format(date);
		} else {
			return "---------- --:--";
		}
		
	}
	
	public static final Date stringToDate(String date) {
		
		final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		try {
			return sdf.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
}
