package kr.green.book.service;

import java.util.ArrayList;
import java.util.List;

import kr.green.book.vo.OrderDetailVO;
import kr.green.book.vo.OrderPageDTO;
import kr.green.book.vo.OrderVO;

public interface OrderService {

	ArrayList<OrderDetailVO> getOrderBook(OrderDetailVO orderDetail);

	ArrayList<OrderVO> getOrderBook(OrderVO order);
	
  //240305	
	List<OrderDetailVO> getOrderList(OrderPageDTO orderPage);

}
