package com.yunstore.resolver;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.yunstore.listener.FileUploadProgressListener;

public class ProgressMultipartResolver extends CommonsMultipartResolver {
	
	@Autowired
    private FileUploadProgressListener progressListener;
	
	public void setFileUploadProgressListener(FileUploadProgressListener progressListener) {
        this.progressListener = progressListener;
        System.out.println("set注入progressListener");
    }
	
	@Override
	protected MultipartParsingResult parseRequest(HttpServletRequest request) throws MultipartException {
		String encoding = determineEncoding(request);
		FileUpload fileUpload = prepareFileUpload(encoding);
		// 除了下面两句，其余是copy了父类方法
		progressListener.setSession(request.getSession());
        fileUpload.setProgressListener(progressListener);
		try {
			List<FileItem> fileItems = ((ServletFileUpload) fileUpload).parseRequest(request);
			return parseFileItems(fileItems, encoding);
		}
		catch (FileUploadBase.SizeLimitExceededException ex) {
			throw new MaxUploadSizeExceededException(fileUpload.getSizeMax(), ex);
		}
		catch (FileUploadBase.FileSizeLimitExceededException ex) {
			throw new MaxUploadSizeExceededException(fileUpload.getFileSizeMax(), ex);
		}
		catch (FileUploadException ex) {
			throw new MultipartException("Failed to parse multipart servlet request", ex);
		}
	}
	
}
