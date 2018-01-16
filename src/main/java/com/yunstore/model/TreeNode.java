package com.yunstore.model;

import java.util.ArrayList;
import java.util.List;

public class TreeNode {
	
	private String id;
	
	private String name;

	private boolean file;

	private String url;
	
	private List<TreeNode> children;
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	public boolean isFile() {
		return file;
	}

	public void setFile(boolean file) {
		this.file = file;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	/**
	 * TreeNode 的使用对应用户查看目录结构，它是多实例的，不存在线程安全问题。
	 */
	public List<TreeNode> getChildren() {
		if(children == null) {
			children = new ArrayList<TreeNode>();
		}
		return children;
	}
	
	public void setChildren(List<TreeNode> children) {
		this.children = children;
	}
	
}
