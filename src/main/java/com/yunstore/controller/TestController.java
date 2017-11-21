package com.yunstore.controller;

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
import javax.servlet.http.HttpSession;

@Controller
public class TestController {
	
	@Autowired
	private FileService fileService;

	@RequestMapping(value = "/path-login")
	public ModelAndView pathLogin() {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("login");
		return mv;
	}

	@RequestMapping(value = "/login")
	public @ResponseBody ResponseData login(String username, String password, HttpSession session) {

		return  ResponseData.ok();
	}

	@RequestMapping(value = "/home")
	public ModelAndView home() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("other/home");	
		return mv;
	}
	
	@RequestMapping(value = "/path-file-all")
	public ModelAndView fileAll(HttpServletRequest request) {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("file/file-all");
		return mv;
	}
	
	@RequestMapping(value = "/path-file-upload")
	public ModelAndView fileUpload(HttpServletRequest request) {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("file/file-upload");
		return mv;
	}
	
	@RequestMapping("/file-upload")
	public @ResponseBody ResponseData upload(String directory, @RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request, HttpSession session) {

		System.out.println("success"+"---"+file.getOriginalFilename());
		fileService.upload(directory, file, request, session);

		return ResponseData.ok();
	}
	
	@RequestMapping("/file-confirm")
	public ModelAndView confirm() {
			
		ModelAndView mv = new ModelAndView();
		mv.setViewName("other/home");
		return mv;
	}

	@RequestMapping("/look-directory")
	public @ResponseBody ResponseData lookDirectory(String directory) {

		return ResponseData.build(200, "", fileService.lookDirectory(directory));
	}

	@RequestMapping("/find-directory")
	public @ResponseBody ResponseData findDirectory(String parent) {
		
		return ResponseData.build(200, "", fileService.findDirectory(parent));
	}
	
	@RequestMapping("/add-directory")
	public @ResponseBody ResponseData createDirectory(String name, String parent, HttpServletRequest request, HttpSession session) {
		
		fileService.addDirectory(name, parent, session);
		return ResponseData.build(200, "", fileService.findDirectory(""));
	}
	
	@RequestMapping("/update-directory")
	public @ResponseBody ResponseData updateDirectory(String id, String name) {

		fileService.updateDirectory(id, name);
		return ResponseData.build(200, "", fileService.findDirectory(""));
	}
	
	@RequestMapping("/remove-directory")
	public @ResponseBody ResponseData removeDirectory(String id, String parent) {
		
		if(fileService.removeDirectory(id, parent)) {
			return ResponseData.ok();
		} else {
			return ResponseData.build(500, "无法移动");
		}
	}
	
	@RequestMapping("/tree-directory")
	public @ResponseBody ResponseData treeDirectory(String parent) {
		
		return ResponseData.build(200, "", fileService.treeDirectory());
	}
	
}
