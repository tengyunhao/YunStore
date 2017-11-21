package com.yunstore.model;

public class ProgressBar implements java.io.Serializable {
	
	/**
	 * session会放入redis需要支持序列化
	 */
	private static final long serialVersionUID = 1L;

	private long bytesRead;
	
	private long contentLength;
	
    private long items;
    
	public long getBytesRead() {
		return bytesRead;
	}
	
	public void setBytesRead(long bytesRead) {
		this.bytesRead = bytesRead;
	}
	
	public long getContentLength() {
		return contentLength;
	}
	
	public void setContentLength(long contentLength) {
		this.contentLength = contentLength;
	}
	
	public long getItems() {
		return items;
	}
	
	public void setItems(long items) {
		this.items = items;
	}
	
}
