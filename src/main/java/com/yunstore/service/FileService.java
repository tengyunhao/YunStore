package com.yunstore.service;

import java.io.File;
import java.net.URL;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yunstore.entity.FileInfo;
import com.yunstore.model.*;
import org.springframework.web.multipart.MultipartFile;

public interface FileService {
	
	public String uploadFile(String directory, MultipartFile file, HttpServletRequest request, HttpSession session);

	public boolean analysisFile(String file);

	public void downloadFile(String file, HttpServletResponse response);

	public void downloadMultifile(String []fileIds, HttpServletResponse response);

	public List<?> findDirectory(String parent);

    public List<?> lookDirectory(String directory, String user);

	public List<FileNavigationModel> getDirectory(String directory, String user);
	
	public void createDirectory(String name, String parent, String user);
	
	public boolean updateName(String id, String name);
	
	public boolean updatePath(String id, String parent);

    /**
     * 删除文件（文件或文件夹）
     * @param id
     */
	public boolean deleteFile(String id);
	
	public List<TreeNode> treeDirectory(String user);

	public List<TreeNode> treeFile(String user);

	/**
	 * 保存文件（可能是从资料组、分享组、个人分享中转存）
	 * @param directory
	 * @param file
	 */
	public void shoreFile(String directory, String file, String user);

	public PhotoAlbumModel previewFile(String file);

	public FileInfo getFileInfo(String fileId);

	public StorageModel storageType(String user);

	public List<StorageShowModel> storageShow(String user);

	public FileSearchListModel fileSearch(String name, String type, int page, String user);
	
}
