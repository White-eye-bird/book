package kr.green.book.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.green.book.pagination.Criteria;
import kr.green.book.pagination.PageMaker;
import kr.green.book.service.BookService;
import kr.green.book.vo.BasketVO;
import kr.green.book.vo.BookVO;
import kr.green.book.vo.MemberVO;
import kr.green.book.vo.OrderVO;
import kr.green.book.vo.ReviewVO;

@Controller	
public class BookController {
/*
	@Autowired
	BookService bookService;
	책 상세
	@RequestMapping(value = "/select", method = RequestMethod.GET)
	public ModelAndView home (ModelAndView mv, String bo_isbn) {
		BookVO book = bookService.selectBook(bo_isbn);
		mv.addObject("b",book);
		mv.setViewName("/noheader/book/select");
		return mv;
	}
*/
	@Autowired
	BookService bookService;
	/*책 상세*/
	@RequestMapping(value = "/select", method = RequestMethod.GET)
	public ModelAndView home (ModelAndView mv, @RequestParam("bo_isbn") String bo_isbn) {
		BookVO book = bookService.selectBook(bo_isbn);
		mv.addObject("b",book);
		mv.setViewName("/noheader/book/select");
		return mv;
	}
	
	
	
	@RequestMapping(value = "/basket", method = RequestMethod.GET)
	public ModelAndView baskitGet (ModelAndView mv, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mv.setViewName("/noheader/main/login");
		}	else {	
			mv.setViewName("/noheader/book/basket");
			ArrayList <BasketVO> basketList = bookService.getBasketBook(user);
			mv.addObject("basketList",basketList);
		}
		return mv;
	}
	
	/*책 장바구니에 추가 */
	@RequestMapping(value ="/basket/add")
	@ResponseBody
	public Map <Object,Object> baskitAdd (@RequestBody BasketVO basket, MemberVO member, HttpSession session) {
		HashMap <Object,Object> map = new HashMap<Object, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		int res = bookService.addBaskitBook(basket, user);
		map.put("res",res);
		return map;
	}
	@RequestMapping(value ="/basket/update")
	@ResponseBody
	public Map <Object,Object> baskitUpdate (@RequestBody BasketVO basket) {
		HashMap <Object,Object> map = new HashMap<Object, Object>();
		bookService.updateBaskitBook(basket);
		
		return map;
	}
	
	@RequestMapping(value ="/basket/delete")
	@ResponseBody
	public Map <Object,Object> baskitDelet (@RequestBody BasketVO basket) {
		HashMap <Object,Object> map = new HashMap<Object, Object>();
		bookService.deleteBaskitBook(basket);
		
		return map;
	}
	
	/*책 리뷰 컨트롤러*/
	@RequestMapping(value ="/ajax/review/insert", method = RequestMethod.POST)
	public @ResponseBody Map<Object,Object> ajaxReviewInsert (@RequestBody ReviewVO review, HttpSession session) {
		HashMap<Object,Object> map = new HashMap<Object,Object>();// 담아서 결과물을 뷰로 돌려줄 빈 맵을 생성
		MemberVO user = (MemberVO) session.getAttribute("user");	
		String res = bookService.insertReviwe(review, user);
		map.put("res", res);
		return map;
	}
	/*책 리뷰 리스트*/
	@RequestMapping(value ="/ajax/review/list/{bo_isbn}", method = RequestMethod.POST)
	public @ResponseBody Map<Object,Object> ajaxReviewIList ( @RequestBody Criteria cri, @PathVariable ("bo_isbn")String bo_isbn, HttpSession session) {
		HashMap<Object,Object> map = new HashMap<Object,Object>();
		ArrayList<ReviewVO> list = bookService.getReview(bo_isbn, cri);
		
		//덧글 추가 삭제를 위한 사용자 확인
		MemberVO user = (MemberVO) session.getAttribute("user");
		map.put("user", user);
		
		/*댓글 페이지 메이커 설정*/
		int totalCount = bookService.getTotalCountList(bo_isbn);
		PageMaker pm = new PageMaker(totalCount, 5, cri);
		map.put("pm", pm);
		map.put("list", list);
		return map;
	}
	
}
