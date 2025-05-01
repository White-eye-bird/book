package kr.green.book.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.green.book.service.OrderService;
import kr.green.book.vo.CategoryVO;
import kr.green.book.vo.OrderDetailVO;
import kr.green.book.vo.OrderPageDTO;
import kr.green.book.vo.OrderVO;
@Controller
public class OrderController {
	@Autowired
	OrderService orderService;
	
	//주문 페이지로 이동
	@RequestMapping(value = "/order", method = RequestMethod.GET)
	public ModelAndView orderGet (ModelAndView mv, OrderDetailVO orderDetail, HttpSession seeion) {
		System.out.println("컨트롤러 출력:"+orderDetail);
		ArrayList <OrderDetailVO> orderList = orderService.getOrderBook(orderDetail);
		mv.addObject("orderList",orderList);
		mv.setViewName("/noheader/book/order");
		return mv;
	}
/*
	//장바구니 주문(기존것)
	@RequestMapping(value = "/order", method = RequestMethod.POST)
	public ModelAndView orderPost (ModelAndView mv, OrderDetailVO orderDetail, HttpSession seeion) {
		System.out.println(orderDetail);
		
		mv.setViewName("/noheader/book/order");
		return mv;
	}
	*/
	
	/*장바구니 주문 변경
	@RequestMapping(value = "/order", method = RequestMethod.POST)
	public ModelAndView orderPost (ModelAndView mv, @ModelAttribute OrderPageDTO orderPage, HttpSession seeion) {
		System.out.println(orderPage);
		//어떻게 해야 출력하지?
		mv.setViewName("/noheader/book/order");
		return mv;
	*/	
	@RequestMapping(value = "/order", method = RequestMethod.POST)
	public ModelAndView orderPost(ModelAndView mv, @RequestParam Map<String, String> allParams, HttpSession session) {
	    
	    OrderPageDTO orderPage = new OrderPageDTO();
	    List<OrderDetailVO> orderDetailList = new ArrayList<OrderDetailVO>();
	    
	    for (Map.Entry<String, String> entry : allParams.entrySet()) {
	        String key = entry.getKey();
	        String value = entry.getValue();

	        if (key.startsWith("orders")) {
	          String[] parts = key.split("\\[|\\]|\\.");
	          int index = Integer.parseInt(parts[1]);

	          OrderDetailVO orderDetail;
	          if (orderDetailList.size() > index) {
	              orderDetail = orderDetailList.get(index);
	          } else {
	              orderDetail = new OrderDetailVO();
	              orderDetailList.add(orderDetail);
	          }

	          if (parts[3].equals("or_bo_isbn")) {  
	              orderDetail.setOr_bo_isbn(value);
	          } else if (parts[3].equals("or_ea")) {  
	              orderDetail.setOr_ea(Integer.parseInt(value));
	          }

	        }
	    }
	    orderPage.setOrders(orderDetailList);
	    System.out.println(orderPage);
	    //실제 받는 데이터:OrderPageDTO(orders=[OrderDetailVO(or_de_num=0, or_num=0, or_bo_isbn=9788954741255, or_title=null, or_ea=1, or_pay=0), OrderDetailVO(or_de_num=0, or_num=0, or_bo_isbn=9788954741262, or_title=null, or_ea=1, or_pay=0)])
	    List<OrderDetailVO> bookList = orderService.getOrderList(orderPage);//@Autowired 어노테이션을 사용하여 OrderService를 주입 받고 있다면, OrderService의 메소드를 호출할 때 클래스 이름이 아닌 주입 받은 orderService 인스턴스를 사용
	    System.out.println(bookList);
	    //리턴된 데이터:[OrderDetailVO(or_de_num=0, or_num=0, or_bo_isbn=9788954741255, or_title=EBS 50일 수학 (상) (2022년용), or_ea=1, or_pay=7000), OrderDetailVO(or_de_num=0, or_num=0, or_bo_isbn=9788954741262, or_title=EBS 50일 수학 (하) (2022년용) , or_ea=1, or_pay=7500)]

	    mv.addObject("bookList", bookList);
	    mv.setViewName("/noheader/book/order");
	    return mv;
	
	}


	
}
