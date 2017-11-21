package com.yunstore.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.yunstore.model.TreeNode;

public interface FileService {
	
	public void upload(String directory, MultipartFile file, HttpServletRequest request, HttpSession session);

	public List<?> lookDirectory(String directory);

	public List<?> findDirectory(String parent);
	
	public void addDirectory(String name, String parent, HttpSession session);
	
	public void updateDirectory(String id, String name);
	
	public boolean removeDirectory(String id, String parent);
	
	public List<TreeNode> treeDirectory();
	
}
