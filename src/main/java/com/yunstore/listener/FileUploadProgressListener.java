package com.yunstore.listener;

import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.ProgressListener;
import org.springframework.stereotype.Component;

import com.yunstore.model.ProgressBar;

@Component
public class FileUploadProgressListener implements ProgressListener {
	
	private HttpSession session;
	public void setSession(HttpSession session) {
		this.session = session;
		ProgressBar status = new ProgressBar();
		session.setAttribute("status", status);
		System.out.println("session");
	}
	
	@Override
	public void update(long pBytesRead, long pContentLength, int pItems) {
		ProgressBar status = (ProgressBar) session.getAttribute("status");
        status.setBytesRead(pBytesRead);
        status.setContentLength(pContentLength);
        status.setItems(pItems);
	}

}
