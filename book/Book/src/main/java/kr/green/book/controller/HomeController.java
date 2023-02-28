package kr.green.book.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.green.book.pagination.Criteria;
import kr.green.book.pagination.PageMaker;
import kr.green.book.service.BookService;
import kr.green.book.service.CategoryService;
import kr.green.book.service.MemberService;
import kr.green.book.vo.BookVO;
import kr.green.book.vo.CategoryDTO;
import kr.green.book.vo.CategoryVO;
import kr.green.book.vo.MemberVO;

@Controller
public class HomeController {
	@Autowired
	MemberService memberService;
	
	@Autowired
	CategoryService categoryService;
	
	@Autowired
	BookService bookService;
	
	
	@RequestMapping(value= "/")
	public ModelAndView openTilesView(ModelAndView mv){
	    mv.setViewName("/main/home");
	    return mv;
	}
	@RequestMapping(value="/signup", method=RequestMethod.GET)
	public ModelAndView singupGet(ModelAndView mv) {
		mv.setViewName("/noheader/main/signup");
		return mv;
	}
	@RequestMapping(value="/signup", method=RequestMethod.POST)
	public ModelAndView singupPost(ModelAndView mv, MemberVO member) {
		if(memberService.signup(member)) {
			mv.setViewName("redirect:/");
		}else {
			mv.setViewName("redirect:/signup");
		}
		return mv;
	}
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public ModelAndView loginGet(ModelAndView mv) {
		mv.setViewName("/noheader/main/login");
		return mv;
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public ModelAndView loginPost(ModelAndView mv, MemberVO member) {
		
		MemberVO user = memberService.login(member);
		if(member != null) 
			mv.setViewName("redirect:/");
		else 
			mv.setViewName("redirect:/login");
		mv.addObject("user",user);
		
		return mv;
	}
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public ModelAndView logout(ModelAndView mv, HttpSession session) {
		session.removeAttribute("user");
		mv.setViewName("redirect:/");
		return mv;
	}
	/*아이디 비밀번호 찾기*/
	@RequestMapping(value="/find", method=RequestMethod.GET)
	public ModelAndView findGet(ModelAndView mv, String type) {
		mv.addObject("type", type);
		mv.setViewName("/noheader/main/find");
		return mv;
	}
	
	
	@RequestMapping(value="/ajax/find/id")
	@ResponseBody
	public Map<Object,Object> findId(@RequestBody MemberVO member) {
		HashMap<Object,Object> map = new HashMap<Object,Object>();
		String id = memberService.getId(member);
		map.put("id",id);
		return map;
	}
	
	
	@RequestMapping(value="/ajex/find/pw")
	@ResponseBody
	public Map<Object,Object> findPw(@RequestBody MemberVO member) {
		HashMap<Object,Object> map = new HashMap<Object,Object>();
		boolean res = memberService.findPw(member);
		map.put("res",res);
		return map;
	}
	
	
	/*관리자 페이지로 이동*/
	@RequestMapping(value="/admin", method=RequestMethod.GET)
	public ModelAndView adminGet(ModelAndView mv) {
		mv.setViewName("/adminheader/admin/home");
		return mv;
	}
	
	/*관리자 페이지 -> 카테고리 등록*/
	@RequestMapping(value="/admin/addcategory", method=RequestMethod.GET)
	public ModelAndView adminAddCategoryGet(ModelAndView mv) {
		mv.setViewName("/adminheader/admin/addcategory");
		return mv;  
 	} 
	/*관리자 페이지 카테고리 등록 기능*/
	@RequestMapping(value="/admin/addcategory", method=RequestMethod.POST)
	public ModelAndView adminAddCategoryPOST(ModelAndView mv, CategoryVO category) {
		System.out.println(category);
		boolean res = categoryService.insertCategory(category);
		mv.setViewName("redirect:/admin/addcategory");
		return mv;
	} 
	/*관리자 페이지 -> 카테고리 등록  분류 Ajax*/
	@RequestMapping(value="/admin/category", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object,Object> adminCategory(@RequestBody CategoryDTO cvo) {
		HashMap<Object,Object> map = new HashMap<Object, Object>();
		ArrayList<CategoryVO> res = categoryService.getCategoryList(cvo);
		map.put("list", res);
		return map;
	}
	
	/*관리자 페이지 -> 도서 등록 */
	@RequestMapping(value="/admin/addbook", method=RequestMethod.GET)
	public ModelAndView adminAddBookGet(ModelAndView mv) {
		mv.setViewName("/adminheader/admin/addbook");
		return mv;
	}
	
	/*관리자 페이지 -> 도서 등록 진행 중*/
	@RequestMapping(value="/admin/addbook", method=RequestMethod.POST)
	public ModelAndView adminAddBookPOST(ModelAndView mv,BookVO book, MultipartFile file) {
		
		bookService.insertbook(book,file);
		mv.setViewName("redirect:/admin/addbook");
		return mv;
	}
	/*관리자 페이지 -> 도서 등록  분류 Ajax*/
	@RequestMapping(value="/admin/book", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object,Object> adminAddBookCategory(@RequestBody CategoryDTO cvo) {
		HashMap<Object,Object> map = new HashMap<Object, Object>();
		ArrayList<CategoryVO> res = categoryService.getCategoryList(cvo);
		map.put("list", res);
		return map;
	}
	
	/*홈 페이지 -> 도서 리스트 (페이지네이션 적용)*/
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public ModelAndView listGet(ModelAndView mv, Criteria cri) {
		cri.setPerPageNum(2);
		ArrayList<BookVO> list = bookService.getBookList(cri);
		int totalCount = bookService.getTotalCount();
		PageMaker pm = new PageMaker(totalCount, 5, cri);
		mv.addObject("pm",pm);
		mv.addObject("list",list);
		mv.setViewName("/main/list");
		return mv;
	}
}
	
	