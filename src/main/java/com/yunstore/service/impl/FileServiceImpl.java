package com.yunstore.service.impl;

import java.io.*;
import java.net.URI;
import java.net.URL;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yunstore.entity.*;
import com.yunstore.mapper.FileTypeDicMapper;
import com.yunstore.mapper.TeacherStorageTypeMapper;
import com.yunstore.model.*;
import com.yunstore.utils.*;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataOutputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IOUtils;
import org.apache.hadoop.util.hash.Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.yunstore.mapper.FileDirectoryMapper;
import com.yunstore.mapper.FileInfoMapper;
import com.yunstore.service.FileService;
import sun.text.resources.iw.FormatData_iw_IL;

@Service
public class FileServiceImpl implements FileService {

	@Autowired
	private FileInfoMapper fileInfoMapper;
	@Autowired
	private FileDirectoryMapper fileDirectoryMapper;
	@Autowired
	private FileTypeDicMapper fileTypeDicMapper;
	@Autowired
	private TeacherStorageTypeMapper teacherStorageTypeMapper;

	/**
	 * 添加一个文件夹到某个目录
	 * @param name：文件夹名称
	 * @param parent：该文件夹的父文件夹
	 * @param user
	 */
	@Override
	public void createDirectory(String name, String parent, String user) {

        parent = parent == null ? "" : parent;

		FileDirectory fileDirectory = new FileDirectory();
		fileDirectory.setName(name);
		fileDirectory.setParent(parent);
		fileDirectory.setTime(DateUtil.dateToString(new Date()));
		fileDirectory.setUser(user);

        FileDirectory parentDirectory = null;
        if(!parent.equals("")) {
            parentDirectory = fileDirectoryMapper.selectByPrimaryKey(parent);
            fileDirectory.setDepth(parentDirectory.getDepth()+1);
        } else {
            fileDirectory.setDepth(0);
        }

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
	 * 查看该目录下的文件（包括文件夹和文件）
	 * @param directory：所查看的目录
	 * @param user：所登陆的用户
	 * @return
	 */
	@Override
	public List<FileModel> lookDirectory(String directory, String user) {

		FileDirectoryExample fileDirectoryExample = new FileDirectoryExample();
		FileInfoExample fileInfoExample = new FileInfoExample();
		System.out.println(directory+"---"+user);
		if(directory != null && !directory.equals("")) {
			fileDirectoryExample.createCriteria().andParentEqualTo(directory);
			fileInfoExample.createCriteria().andDirectoryEqualTo(directory);
		} else {
			fileDirectoryExample.createCriteria().andParentEqualTo("").andUserEqualTo(user);
			fileInfoExample.createCriteria().andDirectoryEqualTo("").andTeacherEqualTo(user);
		}
		List<FileDirectory> fileDirectorys = fileDirectoryMapper.selectByExample(fileDirectoryExample);
		List<FileInfo> fileInfos = fileInfoMapper.selectByExample(fileInfoExample);

		List<FileModel> list = new ArrayList<>();
		for (FileDirectory fileDirectory : fileDirectorys) {
			FileModel fileModel = new FileModel();
			fileModel.setId(fileDirectory.getId());
			fileModel.setName(fileDirectory.getName());
			fileModel.setSize("-");
			fileModel.setType("-");
			fileModel.setTime(fileDirectory.getTime());
            fileModel.setDirectory(fileDirectory.getParent());
            fileModel.setDepth(fileDirectory.getDepth());
			list.add(fileModel);
		}
		for (FileInfo fileInfo : fileInfos) {
			FileModel fileModel = new FileModel();
			fileModel.setId(fileInfo.getId());
			fileModel.setName(fileInfo.getName());
			fileModel.setSize(FileUtil.getSize(fileInfo.getUrl()));
			fileModel.setType(fileInfo.getType() == null ? "" : fileTypeDicMapper.selectByPrimaryKey(fileInfo.getType()).getType());
			fileModel.setTime(fileInfo.getTime());
            fileModel.setDirectory(fileInfo.getDirectory());
			list.add(fileModel);
		}

		return list;
	}

    @Override
    public List<FileNavigationModel> getDirectory(String directory, String user) {
        // 存放父目录，用于路径展示
        List<FileNavigationModel> navigationList = new ArrayList<>();
        if(directory == null && directory.equals("")){
            return navigationList;
        }
        String parent = directory;
        // 往上找两级目录
        for (int i = 0; i < 3; i++) {
            FileDirectory parentDirectory = fileDirectoryMapper.selectByPrimaryKey(parent);
            if(parentDirectory == null) {
                break;
            }
            FileNavigationModel navigation = new FileNavigationModel();
            navigation.setId(parentDirectory.getId());
            navigation.setName(parentDirectory.getName());
            navigation.setDepth(parentDirectory.getDepth());
            navigationList.add(navigation);
            parent = parentDirectory.getParent();
        }
        return navigationList;
    }

	/**
	 * 更新文件夹或文件名称
	 * @param id
	 * @param name
	 */
	@Override
	public boolean updateName(String id, String name) {

		FileInfo fileInfo = new FileInfo();
		fileInfo.setId(id);
		fileInfo.setName(name);
		fileInfo.setTime(DateUtil.dateToString(new Date()));
		if(fileInfoMapper.updateByPrimaryKeySelective(fileInfo) == 1) {
			return true;
		}
		// 不是文件，则是文件夹
		FileDirectory fileDirectory = new FileDirectory();
		fileDirectory.setId(id);
		fileDirectory.setName(name);
		fileDirectory.setTime(DateUtil.dateToString(new Date()));
		if(fileDirectoryMapper.updateByPrimaryKeySelective(fileDirectory) == 1) {
			return true;
		}
		return false;
	}

	/**
	 * 移动文件夹位置
	 * @param id
	 * @param parent
	 * @return
	 */
	@Override
	public boolean updatePath(String id, String parent) {

		FileInfo fileInfo = new FileInfo();
		fileInfo.setId(id);
		fileInfo.setDirectory(parent);
		fileInfo.setTime(DateUtil.dateToString(new Date()));
		if(fileInfoMapper.updateByPrimaryKeySelective(fileInfo) == 1) {
			return true;
		}
		// 不是文件夹，则是文件
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
		// 移动文件夹到指定父目录下
		FileDirectory fileDirectory = new FileDirectory();
		fileDirectory.setId(id);
		fileDirectory.setParent(parent);
		fileDirectory.setTime(DateUtil.dateToString(new Date()));
		if(fileDirectoryMapper.updateByPrimaryKeySelective(fileDirectory) == 1) {
			return true;
		}
		return false;
	}

	@Override
	public boolean deleteFile(String id) {

		// 只是文件
		if(fileInfoMapper.deleteByPrimaryKey(id) == 1) {
			return true;
		}
		// 不是文件，则是文件夹
		if(fileDirectoryMapper.deleteByPrimaryKey(id) == 1) {
			System.out.println("目录删除中");
			// 递归删除
			deleteFolder(id);
			return true;
		}

		return false;
	}

	/**
	 * 递归删除文件夹下的所有子文件夹及文件
	 * @param parent
	 */
	private void deleteFolder(String parent) {

		FileDirectoryExample fileDirectoryExample = new FileDirectoryExample();
		fileDirectoryExample.createCriteria().andParentEqualTo(parent);
		// 删除当前目录下的所有子文件夹
		List<FileDirectory> fileDirectoryList = fileDirectoryMapper.selectByExample(fileDirectoryExample);
		for (FileDirectory fileDirectory : fileDirectoryList) {
			if(fileDirectoryMapper.deleteByPrimaryKey(fileDirectory.getId()) == 1) {
				System.out.println("子目录："+fileDirectory.getName()+"删除成功");
				deleteFolder(fileDirectory.getId());
			}
		}
		// 删除当前目录下的所有子文件
		FileInfoExample fileInfoExample = new FileInfoExample();
		fileInfoExample.createCriteria().andDirectoryEqualTo(parent);
		List<FileInfo> fileInfoList = fileInfoMapper.selectByExample(fileInfoExample);
		for (FileInfo fileInfo : fileInfoList) {
			if(fileInfoMapper.deleteByPrimaryKey(fileInfo.getId()) == 1) {
				System.out.println("文件："+fileInfo.getName()+"删除成功");
			}
		}
	}

	/**
	 * 以树状结构得到所有文件夹
	 * @return
	 */
	@Override
	public List<TreeNode> treeDirectory(String user) {

		FileDirectoryExample example = new FileDirectoryExample();
		// 用户ID作为查找条件
		example.createCriteria().andUserEqualTo(user);
		// 查找用户的所有文件夹
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
		return createTreeDirectory(null, filesMap);
	}

	/**
	 * 构造文件夹树，递归
	 */
	private List<TreeNode> createTreeDirectory(FileDirectory file, HashMap<String, ArrayList<FileDirectory>> filesMap) {

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
			node.setChildren(createTreeDirectory(child, filesMap));
			nodes.add(node);
		}
		return nodes;
	}

	/**
	 * 以树状结构得到所有文件夹和文件
	 * @return
	 */
	@Override
	public List<TreeNode> treeFile(String user) {

		FileDirectoryExample example = new FileDirectoryExample();
		// 用户ID作为查找条件
		example.createCriteria().andUserEqualTo(user);
		// 查找用户的所有文件夹
		List<FileDirectory> fileDirectorys = fileDirectoryMapper.selectByExample(example);
		// 按照父文件分组
		HashMap<String, ArrayList<FileDirectory>> filesMap = new HashMap<>();
		for (FileDirectory fileDirectory : fileDirectorys) {
			String parent = fileDirectory.getParent();
			ArrayList<FileDirectory> files = filesMap.get(parent);
			if(files == null) {
				files = new ArrayList<>();
				filesMap.put(parent, files);
			}
			files.add(fileDirectory);
		}
		// 构造文件树
		return createTreeFile(null, filesMap, user);
	}

	/**
	 * 构造文件夹和文件树，递归
	 */
	private List<TreeNode> createTreeFile(FileDirectory file, HashMap<String, ArrayList<FileDirectory>> filesMap, String user) {

		String parent = (file == null ? "" : file.getId());
		// 获取该目录下的文件夹
		ArrayList<FileDirectory> children = filesMap.get(parent);
		// 获取该目录下的文件
		FileInfoExample example = new FileInfoExample();
		example.createCriteria().andDirectoryEqualTo(parent).andTeacherEqualTo(user);
		List<FileInfo> files = fileInfoMapper.selectByExample(example);

		ArrayList<TreeNode> nodes = new ArrayList<TreeNode>();
		if(files != null) {
			for (FileInfo fileInfo : files) {
				System.out.println(fileInfo.getName());
				TreeNode node = new TreeNode();
				nodes.add(node);
				node.setId(fileInfo.getId());
				node.setName(fileInfo.getName());
				node.setFile(true);
				node.setUrl(fileInfo.getUrl());
			}
		}
		if(children != null) {
			for (FileDirectory child : children) {
				TreeNode node = new TreeNode();
				node.setId(child.getId());
				node.setName(child.getName());
				node.setChildren(createTreeFile(child, filesMap, user));
				nodes.add(node);
			}
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
	public String uploadFile(String directory, MultipartFile file, HttpServletRequest request, HttpSession session) {

		String user = (String) session.getAttribute("user");
		// 文件不为空
		if(file.isEmpty()) {

		}
		// 文件名称
		// 获取文件的类型
		String type = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf('.')+1);
		String name = String.valueOf(new Date().getTime()+"_"+file.getSize())+"."+type;
//		String path = "/Users/tengyunhao/Documents/dev/"+user+"/";
		String path = "/home/data/file/"+user+"/";
        try {
            HDFSUtil.getInstance().uploadFile(path+name,path+name);
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 文件转存
		File localFile = new File(path+name);
		File foler = new File(path);
		if(!foler.exists()) {
            foler.mkdirs();
        }
		try {
			file.transferTo(localFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
		FileInfo fileInfo = new FileInfo();
		fileInfo.setUrl(path+name);
		fileInfo.setName(file.getOriginalFilename());
		fileInfo.setDirectory(directory);
		fileInfo.setTeacher(user);
		fileInfo.setTime(DateUtil.dateToString(new Date()));
		FileTypeDicExample fileTypeDicExample = new FileTypeDicExample();
		fileTypeDicExample.createCriteria().andTypeEqualTo(type);
		List<FileTypeDic> list = fileTypeDicMapper.selectByExample(fileTypeDicExample);
		if(list.size() > 0) {
			fileInfo.setType(list.get(0).getId());
		} else {
			fileTypeDicExample = new FileTypeDicExample();
			fileTypeDicExample.createCriteria().andTypeEqualTo("null");
			fileInfo.setType(fileTypeDicMapper.selectByExample(fileTypeDicExample).get(0).getId());
		}
		// 文件信息存入数据库
		fileInfoMapper.insert(fileInfo);
		// 更改文件类型所占容量
		teacherStorageInsert(user, fileInfo, (int)localFile.length()/1024);
        System.out.println("文件ID："+fileInfo.getId());
        return fileInfo.getId();
	}

    /**
     * 生成预览文件
     * @param file
     */
	@Override
	public boolean analysisFile(String file) {

	    FileInfo fileInfo = fileInfoMapper.selectByPrimaryKey(file);
	    String path = fileInfo.getUrl().substring(0,fileInfo.getUrl().lastIndexOf('/')+1);
        String type = fileInfo.getUrl().substring(fileInfo.getUrl().lastIndexOf('.')+1);
//        String path = "";

        if(type.equals("doc") || type.equals("docx")
                || type.equals("ppt") || type.equals("pptx")
                || type.equals("xls") || type.equals("xlsx")) {
            File pdf = PreviewUtil.office2PDF(new File(fileInfo.getUrl()), path, type);
            if(pdf == null) {
                return false;
            }
            PreviewUtil.PDF2IMG(pdf, path);
        } else if (type.equals("pdf")) {
            PreviewUtil.PDF2IMG(new File(fileInfo.getUrl()), path);
        } else if (type.equals("png")) {

        } else if (type.equals("mp3")) {

        } else if (type.equals("mp4")) {

        }
        return true;
	}

	/**
	 * 下载文件
	 * @param fileId
	 * @param response
	 */
	@Override
	public void downloadFile(String fileId, HttpServletResponse response) {
		if(fileId == null) {

		}
		FileInfo fileInfo = fileInfoMapper.selectByPrimaryKey(fileId);
		// 获取文件
		File file = new File(fileInfo.getUrl());
        try {
            HDFSUtil.getInstance().downloadFile(fileInfo.getUrl(),file);
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 如果文件不存在
		if(!file.exists()) {

		}
		response.setContentType("application/force-download");// 设置强制下载不打开
		response.addHeader("Content-Disposition","attachment;fileName=" + fileInfo.getName());// 设置文件名
		byte[] buffer = new byte[1024];
		FileInputStream fis = null;
		BufferedInputStream bis = null;
		try {
			fis = new FileInputStream(file);
			bis = new BufferedInputStream(fis);
			OutputStream os = response.getOutputStream();
			int i = bis.read(buffer);
			while (i != -1) {
				os.write(buffer, 0, i);
				i = bis.read(buffer);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				bis.close();
				fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

    @Override
    public void downloadMultifile(String[] fileIds, HttpServletResponse response) {

	    File[] multifile = new File[fileIds.length];
        for (int i = 0; i < multifile.length; i++) {
            String fileId = fileIds[i];
            System.out.println(fileId);
            // 获取文件信息
            FileInfo fileInfo = fileInfoMapper.selectByPrimaryKey(fileId);
            if(fileInfo == null) {
                continue;
            }
            // 获取文件
            File file = new File(fileInfo.getUrl());
            multifile[i] = file;
        }
        // 将文件压缩
        File tempFile = new File("/home/data/zip/"+new Date().getTime()+".zip");
        ZIPUtil.zipFiles(multifile, tempFile);

        response.setContentType("application/force-download");// 设置强制下载不打开
        response.addHeader("Content-Disposition","attachment;fileName=" + tempFile.getName());// 设置文件名
        byte[] buffer = new byte[1024];
        FileInputStream fis = null;
        BufferedInputStream bis = null;
        try {
            fis = new FileInputStream(tempFile);
            bis = new BufferedInputStream(fis);
            OutputStream os = response.getOutputStream();
            int i = bis.read(buffer);
            while (i != -1) {
                os.write(buffer, 0, i);
                i = bis.read(buffer);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                bis.close();
                fis.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
	 * 保存文件（可能是从资料组、分享组、个人分享中转存）
	 * @param directory 要保存到哪个目录
	 * @param file 所保存的文件或文件夹
	 */
	@Override
	public void shoreFile(String directory, String file, String user) {
		FileInfo fileInfo = fileInfoMapper.selectByPrimaryKey(file);
		if(fileInfo != null) { //保存的是"文件"
			if(fileInfo.getTeacher().equals(user)) { //已经是自己的文件
				System.out.println("自己的文件");
				return;
			}
			FileInfo fileInfoCopy = new FileInfo();
			fileInfoCopy.setName(fileInfo.getName());
			fileInfoCopy.setTime(DateUtil.dateToString(new Date()));
			fileInfoCopy.setTeacher(user);
			fileInfoCopy.setDirectory(directory);
			fileInfoCopy.setType(fileInfo.getType());
			fileInfoCopy.setUrl(fileInfo.getUrl());
			fileInfoMapper.insert(fileInfoCopy);
			System.out.println("文件转存成功");
			teacherStorageInsert(user, fileInfoCopy, (int)new File(fileInfoCopy.getUrl()).length()/1024);
			return;
		}
		FileDirectory fileDirectory = fileDirectoryMapper.selectByPrimaryKey(file);
		if(fileDirectory != null) { //保存的是"文件夹"
			if(fileDirectory.getUser().equals(user)) { //已经是自己的文件
				System.out.println("自己的文件夹");
				return;
			}
			FileDirectory fileDirectoryCopy = new FileDirectory();
			fileDirectoryCopy.setName(fileDirectory.getName());
			fileDirectoryCopy.setTime(DateUtil.dateToString(new Date()));
			fileDirectoryCopy.setUser(user);
			fileDirectoryCopy.setParent(directory);

            FileDirectory parentDirectory = null;
            if(!directory.equals("")) {
                parentDirectory = fileDirectoryMapper.selectByPrimaryKey(directory);
                fileDirectoryCopy.setDepth(parentDirectory.getDepth()+1);
            } else {
                fileDirectoryCopy.setDepth(0);
            }

			fileDirectoryMapper.insert(fileDirectoryCopy);
			System.out.println("文件转存成功，深度："+fileDirectoryCopy.getDepth());
			// "文件夹"需要递归转存他的"子文件"和"子文件夹"
			shoreFileRecursion(fileDirectory.getId(), fileDirectoryCopy.getId(), fileDirectoryCopy.getDepth()+1, user);
			return;
		}
		System.out.println("找不到该文件或文件夹");
	}

	/**
	 * 递归转存该目录下的所有文件和文件夹
	 * @param directoryOld
	 * @param directoryNew
	 * @param user
	 */
	private void shoreFileRecursion(String directoryOld, String directoryNew, Integer depth, String user) {

		// 找出该目录下的所有"文件夹"
		FileDirectoryExample fileDirectoryExample = new FileDirectoryExample();
		fileDirectoryExample.createCriteria().andParentEqualTo(directoryOld);
		List<FileDirectory> fileDirectoryList = fileDirectoryMapper.selectByExample(fileDirectoryExample);
		// 遍历这些"文件夹"进行转存
		for (FileDirectory fileDirectory : fileDirectoryList) {
			FileDirectory fileDirectoryCopy = new FileDirectory();
			fileDirectoryCopy.setName(fileDirectory.getName());
			fileDirectoryCopy.setTime(DateUtil.dateToString(new Date()));
			fileDirectoryCopy.setUser(user);
			fileDirectoryCopy.setParent(directoryNew);
			fileDirectoryCopy.setDepth(depth);
			fileDirectoryMapper.insert(fileDirectoryCopy);
			System.out.println("文件夹转存成功,深度："+depth+"，新文件夹的ID："+fileDirectoryCopy.getId());
			// 因为是文件夹，则继续递归转存其子文件和子文件夹
			shoreFileRecursion(fileDirectory.getId(), fileDirectoryCopy.getId(), depth+1, user);
		}

		// 找出该目录下的所有"文件"
		FileInfoExample fileInfoExample = new FileInfoExample();
		fileInfoExample.createCriteria().andDirectoryEqualTo(directoryOld);
		List<FileInfo> fileInfoList = fileInfoMapper.selectByExample(fileInfoExample);
		// 遍历这些"文件"进行转存
		for (FileInfo fileInfo : fileInfoList) {
			FileInfo fileInfoCopy = new FileInfo();
			fileInfoCopy.setName(fileInfo.getName());
			fileInfoCopy.setTime(DateUtil.dateToString(new Date()));
			fileInfoCopy.setTeacher(user);
			fileInfoCopy.setDirectory(directoryNew);
			fileInfoCopy.setType(fileInfo.getType());
			fileInfoCopy.setUrl(fileInfo.getUrl());
			fileInfoMapper.insert(fileInfoCopy);
			System.out.println("文件转存成功");
			teacherStorageInsert(user, fileInfoCopy, (int)new File(fileInfoCopy.getUrl()).length()/1024);
		}
	}

	@Override
	public PhotoAlbumModel previewFile(String file) {

		String url = fileInfoMapper.selectByPrimaryKey(file).getUrl();
		String path = url.substring(0,url.lastIndexOf('.'));
        String name = path.substring(path.lastIndexOf('/')+1);
		File sourceFile = new File(path);
		PhotoAlbumModel photoAlbumModel = new PhotoAlbumModel();
		photoAlbumModel.setTitle("测试");
		photoAlbumModel.setData(new ArrayList<>());

		for (int i = 0; i < sourceFile.listFiles().length; i++) {
			PhotoModel photoModel = new PhotoModel();
			photoModel.setAlt("测试");
			photoModel.setSrc("http://121.42.145.183:8080"+path.substring(url.indexOf("/file"))+"/"+name+"_"+i+".png");
			photoAlbumModel.getData().add(photoModel);
		}
		return photoAlbumModel;
	}

	@Override
	public FileInfo getFileInfo(String fileId) {

		FileInfo fileInfo = fileInfoMapper.selectByPrimaryKey(fileId);

		return fileInfo;
	}

	@Override
	public StorageModel storageType(String user) {

		TeacherStorageTypeExample example = new TeacherStorageTypeExample();
		example.createCriteria().andTeacherEqualTo(user);
		List<TeacherStorageType>  list = teacherStorageTypeMapper.selectByExample(example);
		Map<String, Integer> typeMap = new HashMap<>();
		for (TeacherStorageType type : list) {
			if(type.getShowtype() == 1) {
				FileTypeDic dic = fileTypeDicMapper.selectByPrimaryKey(type.getFiletype());
				Integer size = typeMap.get(dic.getName());
				if(size == null) size = 0;
				typeMap.put(dic.getName(), size+type.getSize());
			} else {
				Integer size = typeMap.get("其他");
				if(size == null) size = 0;
				typeMap.put("其他", size+type.getSize());
			}
		}
		int used = 0;
		List<StorageTypeModel> storageTypeList = new ArrayList<>();
		Map<String, Integer> map = new HashMap<>();
		for (String key : typeMap.keySet()) {
			StorageTypeModel storageTypeModel = new StorageTypeModel();
			storageTypeModel.setType(key);
			storageTypeModel.setSize(FileUtil.getSizeOfUnit(typeMap.get(key).doubleValue(), FileUtil.FizeSize.KB));
			storageTypeModel.setLength(typeMap.get(key));
			storageTypeModel.setUsed(typeMap.get(key),1024*1024);
			storageTypeList.add(storageTypeModel);
			used += typeMap.get(key);
			map.put(key,typeMap.get(key));
		}

		StorageModel storageModel = new StorageModel();
		storageModel.setList(storageTypeList);
		storageModel.setTotal(FileUtil.getSizeOfUnit(1024*1024, FileUtil.FizeSize.KB));
		storageModel.setSurplus(FileUtil.getSizeOfUnit(1024*1024-used, FileUtil.FizeSize.KB));
		storageModel.setPercent(used*100/(1024*1024));
		storageModel.setPie(new StoragePieModel(map));
		return storageModel;
	}

	/**
	 * 用户存储空间
	 * @param user
	 * @return
	 */
	@Override
	public List<StorageShowModel> storageShow(String user) {
		System.out.println(user);
		TeacherStorageTypeExample example = new TeacherStorageTypeExample();
		example.createCriteria().andTeacherEqualTo(user);
		List<TeacherStorageType> list = teacherStorageTypeMapper.selectByExample(example);
		List<StorageShowModel> models = new ArrayList<>();
		Map<String, StorageShowModel> modelMap = new HashMap<>();
		for (TeacherStorageType type : list) {
			FileTypeDic dic = fileTypeDicMapper.selectByPrimaryKey(type.getFiletype());
			if(modelMap.containsKey(dic.getName())) {
				continue;
			} else {
				modelMap.put(dic.getName(), null);
			}
			StorageShowModel storageShowModel = new StorageShowModel();
			storageShowModel.setId(type.getFiletype());
			storageShowModel.setShow(type.getShowtype() == 1 ? "yes" : "no");
			storageShowModel.setType(dic.getName());
			models.add(storageShowModel);
		}

		return models;
	}

	/**
	 *  复制整个文件夹内容（物理复制）
	 *  @param  oldPath  String  原文件路径  如：c:/fqf
	 *  @param  newPath  String  复制后路径  如：f:/fqf/ff
	 *  @return  boolean
	 */
	private void copyFolder(String oldPath, String newPath) {
		try {
			new File(newPath).mkdirs();  //如果文件夹不存在  则建立新文件夹
			File a = new File(oldPath);
			String[] file=a.list();
			File temp = null;
			for (int i = 0; i < file.length; i++) {
				if(oldPath.endsWith(File.separator)) {
					temp = new File(oldPath+file[i]);
				}
				else{
					temp = new File(oldPath+File.separator+file[i]);
				}
				if (temp.isFile()) {
					FileInputStream input = new FileInputStream(temp);
					FileOutputStream output = new FileOutputStream(newPath + "/" + (temp.getName()).toString());
					byte[] b = new byte[1024 * 5];
					int len;
					while((len = input.read(b)) != -1)  {
						output.write(b, 0, len);
					}
					output.flush();
					output.close();
					input.close();
				}
				if (temp.isDirectory()) {//如果是子文件夹
					copyFolder(oldPath+"/"+file[i],newPath+"/"+file[i]);
				}
			}
		}
		catch  (Exception  e)  {
			System.out.println("复制整个文件夹内容操作出错");
			e.printStackTrace();
		}
	}

	/**
	 * 按条件查找文件
	 * @param name
	 * @param type
	 * @param page
	 * @param user
	 * @return
	 */
	@Override
	public FileSearchListModel fileSearch(String name, String type, int page, String user) {

        PageHelper.startPage(page, 10);
        if(name == null) {
            name = "";
        }
        FileInfoExample example = new FileInfoExample();
        FileInfoExample.Criteria criteria = example.createCriteria();
        criteria.andTeacherEqualTo(user);
        if(name != null) {
            criteria.andNameLike("%"+name+"%");
        }
        if(type != null && !type.equals("")) {
            criteria.andTypeEqualTo(type);
        }
        List<FileInfo> list = fileInfoMapper.selectByName(example);

		int count = fileInfoMapper.countByExample(example);
        System.out.println("结果："+list.size());
        System.out.println();
		List<FileSearchModel> modelList = new ArrayList<>();
		for (FileInfo fileInfo : list) {
			FileSearchModel model = new FileSearchModel();
			model.setId(fileInfo.getId());
			model.setName(fileInfo.getName());
			model.setSize(FileUtil.getSize(fileInfo.getUrl()));
			model.setTime(fileInfo.getTime());
			FileTypeDic fileTypeDic = fileTypeDicMapper.selectByPrimaryKey(fileInfo.getType());
			model.setType(fileTypeDic.getName());
			FileDirectory fileDirectory = fileDirectoryMapper.selectByPrimaryKey(fileInfo.getDirectory());
			StringBuffer path = new StringBuffer();
			if (fileDirectory == null) {
				model.setDirectory("");
				path.append("/");
			} else {
				model.setDirectory(fileDirectory.getId());
			}
			while(fileDirectory != null) {
				path.insert(0, " / "+fileDirectory.getName());
				fileDirectory = fileDirectoryMapper.selectByPrimaryKey(fileDirectory.getParent());
			}
			model.setPath(path.toString());
			modelList.add(model);
        }
		FileSearchListModel fileSearchListModel = new FileSearchListModel();
        fileSearchListModel.setList(modelList);
        fileSearchListModel.setLength(count);
		return fileSearchListModel;
	}

	/**
	 * 当文件上传或转存时，更新剩余空间
	 * @param user
	 * @param fileInfo
	 * @param fileSize
	 */
	private void teacherStorageInsert(String user, FileInfo fileInfo, int fileSize) {
		// 更改文件类型所占容量
		TeacherStorageTypeExample teacherStorageTypeExample = new TeacherStorageTypeExample();
		teacherStorageTypeExample.createCriteria().andTeacherEqualTo(user).andFiletypeEqualTo(fileInfo.getType());
		List<TeacherStorageType> typeList = teacherStorageTypeMapper.selectByExample(teacherStorageTypeExample);
		if(typeList.size() > 0) { // 修改该类型的容量
			TeacherStorageType teacherStorageType = typeList.get(0);
			teacherStorageType.setSize(teacherStorageType.getSize()+fileSize);
			teacherStorageTypeMapper.updateByPrimaryKey(teacherStorageType);
		} else {
			TeacherStorageType teacherStorageType = new TeacherStorageType();
			teacherStorageType.setTeacher(user);
			teacherStorageType.setFiletype(fileInfo.getType());
			teacherStorageType.setSize(fileSize);
			teacherStorageType.setShowtype(1);
			teacherStorageTypeMapper.insert(teacherStorageType);
		}
	}
}
