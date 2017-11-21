package com.yunstore.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.yunstore.entity.*;
import com.yunstore.mapper.FileTypeDicMapper;
import com.yunstore.model.FileModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.yunstore.common.Utils;
import com.yunstore.mapper.FileDirectoryMapper;
import com.yunstore.mapper.FileInfoMapper;
import com.yunstore.model.TreeNode;
import com.yunstore.service.FileService;

@Service
public class FileServiceImpl implements FileService {

	@Autowired
	private FileInfoMapper fileInfoMapper;
	@Autowired
	private FileDirectoryMapper fileDirectoryMapper;
	@Autowired
	private FileTypeDicMapper fileTypeDicMapper;

	/**
	 * 添加一个文件夹到某个目录
	 * @param name：文件夹名称
	 * @param parent：该文件夹的父文件夹
	 * @param session
	 */
	@Override
	public void addDirectory(String name, String parent, HttpSession session) {
		
		FileDirectory fileDirectory = new FileDirectory();
		fileDirectory.setName(name);
		fileDirectory.setParent(parent == null ? "" : parent);
		fileDirectory.setTime(Utils.dateToString(new Date()));
		fileDirectoryMapper.insert(fileDirectory);
	}

	/**
	 * 查找一个目录下的子文件夹
	 * @param parent
	 * @return
	 */
	@Override
	public List<FileDirectory> findDirectory(String parent) {

		FileDirectoryExample example = new FileDirectoryExample();
		example.createCriteria().andParentEqualTo(parent == null ? "" : parent);
		List<FileDirectory> list = fileDirectoryMapper.selectByExample(example);
		return list;
	}

	/**
	 * 更新文件夹名称
	 * @param id
	 * @param name
	 */
	@Override
	public void updateDirectory(String id, String name) {

//		FileDirectory fileDirectory = fileDirectoryMapper.selectByPrimaryKey(id);
//		fileDirectory.setName(name);
//		fileDirectory.setTime(Utils.dateToString(new Date()));
//		fileDirectoryMapper.updateByPrimaryKey(fileDirectory);

		FileDirectory fileDirectory = new FileDirectory();
		fileDirectory.setId(id);
		fileDirectory.setName(name);
		fileDirectory.setTime(Utils.dateToString(new Date()));
		fileDirectoryMapper.updateByPrimaryKeySelective(fileDirectory);
	}

	/**
	 * 移动文件夹位置
	 * @param id
	 * @param parent
	 * @return
	 */
	@Override
	public boolean removeDirectory(String id, String parent) {
		// 防止移动到自身的目录即子目录下
		String now = parent;
		while(!id.equals(now)) {
			FileDirectory fileDirectory = fileDirectoryMapper.selectByPrimaryKey(now);
			if(fileDirectory == null) {
				now = null;
				break;
			}
			now = fileDirectory.getParent();
		}
		if(now != null) {
			return false;
		}
		// 移动文件到指定父目录下
		FileDirectory fileDirectory = fileDirectoryMapper.selectByPrimaryKey(id);
		fileDirectory.setParent(parent);
		fileDirectoryMapper.updateByPrimaryKey(fileDirectory);
		return true;
	}

	/**
	 * 以树状结构得到所有文件夹
	 * @return
	 */
	@Override
	public List<TreeNode> treeDirectory() {

		FileDirectoryExample example = new FileDirectoryExample();
		// 用户ID作为查找条件
		// 指定目录的子目录
		List<FileDirectory> fileDirectorys = fileDirectoryMapper.selectByExample(example);
		// 按照父文件分组
		HashMap<String, ArrayList<FileDirectory>> filesMap = new HashMap<>();
		for (FileDirectory fileDirectory : fileDirectorys) {
			String parent = fileDirectory.getParent();
			ArrayList<FileDirectory> files = filesMap.get(parent);
			if(files == null) {
				files = new ArrayList<FileDirectory>();
				filesMap.put(parent, files);
			}
			files.add(fileDirectory);
		}
		// 构造文件树
		return createTree(null, filesMap);
	}

	/**
	 * 构造文件树，递归
	 */
	private List<TreeNode> createTree(FileDirectory file, HashMap<String, ArrayList<FileDirectory>> filesMap) {

		String parent = (file == null ? "" : file.getId());
		ArrayList<FileDirectory> children = filesMap.get(parent);
		if(children == null) {
			return null;
		}
		ArrayList<TreeNode> nodes = new ArrayList<TreeNode>();
		for (FileDirectory child : children) {
			TreeNode node = new TreeNode();
			node.setId(child.getId());
			node.setName(child.getName());
			node.setChildren(createTree(child, filesMap));
			nodes.add(node);
		}
		return nodes;
	}

	/**
	 * 上传文件到某个目录下
	 * @param directory
	 * @param file
	 * @param request
	 * @param session
	 */
	@Override
	public void upload(String directory, MultipartFile file, HttpServletRequest request, HttpSession session) {
		// 文件不为空
		if(!file.isEmpty()) {
			// 文件存放路径
			String path = request.getServletContext().getRealPath("/");
			// 文件名称
			String name = String.valueOf(new Date().getTime()+"_"+file.getSize());
			File destFile = new File(path,name);
			// 转存文件
			try {
				file.transferTo(destFile);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			FileInfo fileInfo = new FileInfo();

			String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
			fileInfo.setName(file.getOriginalFilename());
			fileInfo.setUrl(basePath+name);
			fileInfo.setDirectory(directory);
			fileInfo.setTime(Utils.dateToString(new Date()));
			// 获取文件的类型
			String type = fileInfo.getName().substring(fileInfo.getName().lastIndexOf('.')+1);
			FileTypeDicExample example = new FileTypeDicExample();
			example.createCriteria().andTypeEqualTo(type);
			List<FileTypeDic> list = fileTypeDicMapper.selectByExample(example);
			if(list.size() > 0) {
				fileInfo.setType(list.get(0).getId());
			}
			fileInfoMapper.insert(fileInfo);
		}

	}

	/**
	 * 查看该目录下的文件（包括文件夹和文件）
	 * @param directory：所查看的目录
	 * @return
	 */
	@Override
	public List<FileModel> lookDirectory(String directory) {

		// 文件夹列表
		FileDirectoryExample fileDirectoryExample = new FileDirectoryExample();
		fileDirectoryExample.createCriteria().andParentEqualTo(directory == null ? "" : directory);
		List<FileDirectory> fileDirectorys = fileDirectoryMapper.selectByExample(fileDirectoryExample);
		// 文件列表
		FileInfoExample fileInfoExample = new FileInfoExample();
		fileInfoExample.createCriteria().andDirectoryEqualTo(directory == null ? "" : directory);
		List<FileInfo> fileInfos = fileInfoMapper.selectByExample(fileInfoExample);

		List<FileModel> list = new ArrayList<>();
		for (FileDirectory fileDirectory : fileDirectorys) {
			FileModel fileModel = new FileModel();
			fileModel.setId(fileDirectory.getId());
			fileModel.setName(fileDirectory.getName());
			fileModel.setDirectory(fileDirectory.getParent());
			fileModel.setType("-");
			fileModel.setTime(fileDirectory.getTime());
			list.add(fileModel);
		}
		for (FileInfo fileInfo : fileInfos) {
			FileModel fileModel = new FileModel();
			fileModel.setId(fileInfo.getId());
			fileModel.setName(fileInfo.getName());
			fileModel.setDirectory(fileInfo.getDirectory());
			String type = fileInfo.getType();
			if(type != null) {
				fileModel.setType(fileTypeDicMapper.selectByPrimaryKey(type).getName());
			} else {
				fileModel.setType("未知类型");
			}
			fileModel.setTime(fileInfo.getTime());
			list.add(fileModel);
		}

		return list;
	}

}
