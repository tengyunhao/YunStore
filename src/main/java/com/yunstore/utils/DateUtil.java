package com.yunstore.utils;

import com.yunstore.model.PhotoAlbumModel;
import com.yunstore.model.PhotoModel;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;

public class DateUtil {
	
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

    public static void main(String[] args) {

        System.out.println(MD5Util.getMD5("a476911605"));
    }

}
