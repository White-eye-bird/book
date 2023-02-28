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
import org.springframework.web.servlet.ModelAndView;

import kr.green.book.service.BookService;
import kr.green.book.vo.BasketVO;
import kr.green.book.vo.BookVO;
import kr.green.book.vo.MemberVO;
import kr.green.book.vo.OrderVO;

@Controller	
public class BookController {

	@Autowired
	BookService bookService;
	/*책 상세*/
	@RequestMapping(value = "/select", method = RequestMethod.GET)
	public ModelAndView home (ModelAndView mv, String bo_isbn) {
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
}
