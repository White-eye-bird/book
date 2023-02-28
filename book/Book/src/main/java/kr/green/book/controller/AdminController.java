package kr.green.book.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.green.book.service.CategoryService;
import kr.green.book.vo.CategoryVO;

@Service
public class AdminController {
	@Autowired
	CategoryService categoryService;
	
	
	/*관리자 페이지 -> 도서 등록 jsp 연결만함*/
	@RequestMapping(value="/admin/addbook", method=RequestMethod.GET)
	public ModelAndView adminAddBookGet(ModelAndView mv) {
		mv.setViewName("/adminheader/admin/addbook");
		return mv;
	}
	/*관리자 페이지 -> 카테고리 등록*/
	@RequestMapping(value="/admin/addcategory", method=RequestMethod.GET)
	public ModelAndView adminAddCategoryGet(ModelAndView mv) {
		mv.setViewName("/adminheader/admin/addcategory");
		return mv;  
 	} 
	/*관리자 페이지 -> 대분류 카테고리 등록*/
	@RequestMapping(value="/admin/addcategory", method=RequestMethod.POST)
	public ModelAndView adminAddCategoryPOST(ModelAndView mv, CategoryVO category) {
		System.out.println(category);
		boolean res = categoryService.insertCategory(category);
		mv.setViewName("redirect:/admin/addcategory");
		return mv;
	} 
}
