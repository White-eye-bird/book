package kr.green.book.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.green.book.service.OrderService;
import kr.green.book.vo.OrderDetailVO;
import kr.green.book.vo.OrderVO;
@Controller
public class OrderController {
	@Autowired
	OrderService orderService;

	/*주문 페이지로 이동*/
	@RequestMapping(value = "/order", method = RequestMethod.GET)
	public ModelAndView orderGet (ModelAndView mv, OrderDetailVO orderDetail, HttpSession seeion) {
		System.out.println(orderDetail);
		ArrayList <OrderDetailVO> orderList = orderService.getOrderBook(orderDetail);
		mv.addObject("orderList",orderList);
		mv.setViewName("/noheader/book/order");
		return mv;
	}
}
