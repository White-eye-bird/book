package kr.green.book.service;

import java.util.ArrayList;

import kr.green.book.vo.OrderDetailVO;
import kr.green.book.vo.OrderVO;

public interface OrderService {

	ArrayList<OrderDetailVO> getOrderBook(OrderDetailVO orderDetail);

	

}
