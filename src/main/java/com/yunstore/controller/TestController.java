package com.yunstore.controller;

import com.sun.org.apache.regexp.internal.RE;
import com.yunstore.entity.FileInfo;
import com.yunstore.entity.StudentInfo;
import com.yunstore.model.*;
import com.yunstore.utils.*;
import com.yunstore.entity.TeacherInfo;
import com.yunstore.service.AccountService;
import org.json.HTTP;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.yunstore.common.ResponseData;
import com.yunstore.service.FileService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.Date;
import java.util.List;

@Controller
public class TestController {
	
	@Autowired
	private FileService fileService;
	@Autowired
	private AccountService accountService;

	@RequestMapping(value = "/index")
	public ModelAndView index() {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("main");
		return mv;
	}

    @RequestMapping(value = "/setting/info")
    public ModelAndView setting(HttpSession session) {

        ModelAndView mv = new ModelAndView();
        mv.setViewName("settingInfo");
        return mv;
    }

	@RequestMapping(value = "/login")
	public ModelAndView login() {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("login");
		return mv;
	}

    @RequestMapping(value = "/logout")
    public ModelAndView logout(HttpSession session) {

        session.invalidate();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("login");
        return mv;
    }

    @RequestMapping(value = "/loginface")
    public ModelAndView loginFace() {

        ModelAndView mv = new ModelAndView();
        mv.setViewName("loginFace");
        return mv;
    }

	@RequestMapping(value = "/login-check")
	public @ResponseBody ResponseData loginCheck(String username, String password, HttpSession session, HttpServletResponse response) throws IOException {

        TeacherInfo teacherInfo = accountService.login(username, MD5Util.getMD5(password));
		if(teacherInfo != null) {
			session.setAttribute("user",teacherInfo.getId());
			session.setAttribute("name",teacherInfo.getName());
            session.setMaxInactiveInterval(60*60);
			return ResponseData.ok();
		}
		return ResponseData.build(500, "error");
	}

	@RequestMapping(value = "/login-sms-verify")
	public @ResponseBody ResponseData loginOfSMSerify(String username, HttpSession session) {

		String verifyCode = CodeUtil.getVerifyCode();
		session.setAttribute("verifyCode", verifyCode);
        session.setMaxInactiveInterval(60*5);
		SMSUtil.sendSms(username, verifyCode);

		return ResponseData.ok();
	}

	@RequestMapping(value = "/login-sms-check")
	public @ResponseBody ResponseData loginOfSMSCheck(String username, String verify, HttpSession session, HttpServletResponse response) throws IOException {

        String verifyCode = (String)session.getAttribute("verifyCode");
        System.out.println(username+"---"+verify+"---"+verifyCode);
	    if(verifyCode.equals(verify)) {
            TeacherInfo info = accountService.getId(username);
            System.out.println(info.getName());
            if(info != null) {
                session.setAttribute("user",info.getId());
                session.setAttribute("name",info.getName());
                session.setMaxInactiveInterval(60*30);
                return ResponseData.ok();
            }
        }
        return ResponseData.build(500, "error");
	}

	@RequestMapping(value = "/login-face")
	public @ResponseBody ResponseData loginOfFace(String username, String img, HttpSession session) throws Exception {

		TeacherInfo info = accountService.getId(username);
		img = img.replace("data:image/png;base64,","");
		String face = accountService.getFace(info.getId());
		// 发送POST请求示例
		String ali_ak_id = ""; //用户ak
		String ali_ak_secret = ""; // 用户ak_secret
		String ali_url = "https://dtplus-cn-shanghai.data.aliyuncs.com/face/verify";

//        String ali_body = "{\"type\": \"1\", \"content\":\""+img+"\"}";
//		String result = AESDecode.sendPost(ali_url, ali_body, ali_ak_id, ali_ak_secret);
//        System.out.println(result);

		String ali_body = "{\"type\": \"1\", \"content_1\":\""+face+"\", \"content_2\":\""+img+"\"}";
		String result = AESDecode.sendPost(ali_url, ali_body, ali_ak_id, ali_ak_secret);
        String confidence = result.substring(result.indexOf("\"confidence\":")+"\"confidence\":".length(), result.indexOf(","));
		if(Double.parseDouble(confidence) > 75) {
			System.out.println(info.getName());
			session.setAttribute("user",info.getId());
			session.setAttribute("name",info.getName());
            session.setMaxInactiveInterval(60*15);
			return ResponseData.ok();
		} else {
			return ResponseData.build(200,"no");
		}
//        return ResponseData.build(200,"no");
	}

	@RequestMapping(value = "/update-face")
    public @ResponseBody ResponseData updateFace(String img, HttpSession session) {

        img = img.replace("data:image/png;base64,","");
        String user = (String)session.getAttribute("user");
        if(accountService.updateFace(user, img) || accountService.addFace(user, img)) {
            return ResponseData.ok();
        } else  {
            return ResponseData.build(500,"更新人脸画相失败");
        }
    }

	@RequestMapping(value = "/register")
	public ModelAndView register() {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("register");
		return mv;
	}

	@RequestMapping(value = "/video")
	public ModelAndView video(String video) {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("video");
        FileInfo fileInfo = fileService.getFileInfo(video);
        fileInfo.setUrl("http://121.42.145.183:8080"+fileInfo.getUrl().substring("/home/data".length()));
		mv.getModel().put("fileInfo", fileInfo);
		return mv;
	}

	@RequestMapping(value = "/music")
	public ModelAndView music(String music) {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("music");
        FileInfo fileInfo = fileService.getFileInfo(music);
        fileInfo.setUrl("http://121.42.145.183:8080"+fileInfo.getUrl().substring("/home/data".length()));
		mv.getModel().put("fileInfo", fileInfo);
		return mv;
	}

	@RequestMapping(value = "/time")
	public ModelAndView time() {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("time");
		return mv;
	}

	@RequestMapping(value = "/register/code")
	public @ResponseBody ResponseData registerCheck(String username, HttpSession session) throws IOException {

		String verifyCode = CodeUtil.getVerifyCode();
		session.setAttribute("verifyCode", verifyCode);
		SMSUtil.sendSms(username, verifyCode);
        session.setMaxInactiveInterval(60*5);

		return ResponseData.ok();

	}

	@RequestMapping(value = "/register-check")
	public ModelAndView registerCheck(String username, String password, String code, HttpSession session) throws IOException {

		ModelAndView mv = new ModelAndView();
		String verifyCode = (String) session.getAttribute("verifyCode");
		if(verifyCode.equals(code)) {

            accountService.register(username, password);
			mv.setViewName("login");
		} else {
			mv.setViewName("register");
		}
		return mv;

	}

	@RequestMapping(value = "/friend/list")
	public ModelAndView friend() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("friendList");
		return mv;
	}

	@RequestMapping(value = "/group/material")
	public ModelAndView groupMaterial() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("groupMaterial");
		return mv;
	}

	@RequestMapping(value = "/group/share")
	public ModelAndView groupShare() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("groupShare");
		return mv;
	}
	
	@RequestMapping(value = "/file/list")
	public ModelAndView fileList() {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("fileList");
		return mv;
	}

	@RequestMapping(value = "/file/search")
	public ModelAndView fileSearch(HttpSession session) {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("fileSearch");
		return mv;
	}

	@RequestMapping(value = "/file/storage")
	public ModelAndView fileStorage(HttpSession session) {

		String user = (String) session.getAttribute("user");

		ModelAndView mv = new ModelAndView();
		mv.setViewName("fileStorage");
		StorageModel storageModel = fileService.storageType(user);
		mv.getModelMap().addAttribute("storage", storageModel);
		mv.getModelMap().addAttribute("pie", storageModel.getPie());
		return mv;
	}

	@RequestMapping(value = "/file/search/show")
	public @ResponseBody FileSearchListModel fileSearchShow(String name, String type, String page, HttpSession session) {
		System.out.println(page);
		int p = page == null ? 0 : Integer.parseInt(page);
		String user = (String) session.getAttribute("user");

		return fileService.fileSearch(name, type, p, user);
	}

	@RequestMapping(value = "/file/storage/show")
	public @ResponseBody List<StorageShowModel> storageShow(HttpSession session) {

		String user = (String) session.getAttribute("user");
		return fileService.storageShow(user);
	}
	
	@RequestMapping(value = "/file/upload")
	public ModelAndView fileUpload() {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("fileUpload");
		return mv;
	}
	
	@RequestMapping("/file-upload")
	public @ResponseBody ResponseData uploadFile(String directory, @RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, HttpSession session) {

		String fileId = fileService.uploadFile(directory, file, request, session);
		return ResponseData.ok(fileId);
	}

	@RequestMapping("/file/analysis")
	public @ResponseBody ResponseData analysisFile(String file) {

        boolean result = fileService.analysisFile(file);
        if(result) {
            return ResponseData.ok();
        } else {
            return ResponseData.build(500, "出错");
        }
	}

	@RequestMapping("/file-download")
	public @ResponseBody ResponseData downloadFile(String fileId, HttpServletResponse response, HttpSession session) {

		fileService.downloadFile(fileId, response);
		return ResponseData.ok();
	}

    @RequestMapping("/multifile-download")
    public @ResponseBody ResponseData downloadMultifile(@RequestParam(value = "fileIds") String[] fileIds, HttpServletResponse response, HttpSession session) {

        fileService.downloadMultifile(fileIds, response);
        return ResponseData.ok();
    }

	@RequestMapping("/file-preview")
	public @ResponseBody PhotoAlbumModel previewFile(String file, HttpSession session) {

		return fileService.previewFile(file);
	}

	@RequestMapping("/look-directory")
	public @ResponseBody ResponseData lookDirectory(String directory, HttpSession session) {
		String user = (String) session.getAttribute("user");
		if(user == null) {
		}
		return ResponseData.build(200, "", fileService.lookDirectory(directory, user));
	}

    @RequestMapping("/get-directory")
    public @ResponseBody ResponseData getDirectory(String directory, HttpSession session) {
        String user = (String) session.getAttribute("user");
        if(user == null) {
        }
        return ResponseData.build(200, "", fileService.getDirectory(directory, user));
    }

	@RequestMapping("/find-directory")
	public @ResponseBody ResponseData findDirectory(String parent) {
		
		return ResponseData.build(200, "", fileService.findDirectory(parent));
	}
	
	@RequestMapping("/add-directory")
	public @ResponseBody ResponseData createDirectory(String name, String parent, HttpServletRequest request, HttpSession session) {
		String user = (String) session.getAttribute("user");
		fileService.createDirectory(name, parent, user);
		return ResponseData.build(200, "", fileService.findDirectory(""));
	}
	
	@RequestMapping("/update-directory")
	public @ResponseBody ResponseData updateName(String id, String name) {
		fileService.updateName(id, name);
		return ResponseData.build(200, "", fileService.findDirectory(""));
	}
	
	@RequestMapping("/remove-directory")
	public @ResponseBody ResponseData updatePath(String id, String parent) {
		if(fileService.updatePath(id, parent)) {
			return ResponseData.ok();
		} else {
			return ResponseData.build(500, "无法移动");
		}
	}

	@RequestMapping("/file-delete")
	public @ResponseBody ResponseData delete(String id) {
		if(fileService.deleteFile(id)) {
			return ResponseData.ok();
		} else {
			return ResponseData.build(500, "删除出错");
		}
 	}
	
	@RequestMapping("/tree-directory")
	public @ResponseBody ResponseData treeDirectory(String parent, HttpSession session) {
		String user = (String) session.getAttribute("user");
		return ResponseData.build(200, "", fileService.treeDirectory(user));
	}

	@RequestMapping("/tree-file")
	public @ResponseBody ResponseData treeFile(String directory, HttpSession session) {
		String user = (String) session.getAttribute("user");
		return ResponseData.ok(fileService.treeFile(user));
	}

	@RequestMapping("/store-file")
	public @ResponseBody ResponseData storeFile(String directory, @RequestParam(value = "files[]") String[] files, HttpSession session) {
		for(String file : files) {
			fileService.shoreFile(directory, file, (String) session.getAttribute("user"));
		}
		return ResponseData.ok();
	}
	
}
