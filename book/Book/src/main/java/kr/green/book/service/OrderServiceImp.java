package kr.green.book.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.book.dao.BookDAO;
import kr.green.book.dao.OrderDAO;
import kr.green.book.vo.BookVO;
import kr.green.book.vo.OrderDetailVO;
import kr.green.book.vo.OrderVO;

@Service	
public class OrderServiceImp implements OrderService{
	@Autowired 
	OrderDAO orderDao; 
	BookDAO	bookDao;
	
	
/*
	@Override
	public ArrayList<OrderVO> getOrderBook(OrderVO order) {
			
			ArrayList<BookVO> dbBook = bookDao.selectOrderBook(book);
			//리스트의 값 변경(get index)
			dbBook.get(0).setBo_ea(book.getBo_ea());
			return dbBook;
		}
		
		*/

	@Override
	public ArrayList<OrderDetailVO> getOrderBook(OrderDetailVO orderDetail) {
		if(orderDetail.getOr_bo_isbn() == null || orderDetail.getOr_bo_isbn().length() !=13 )
			return null;
		if(orderDetail.getOr_ea()<1 || orderDetail.getOr_ea()>200)
			return null;
		
		ArrayList<OrderDetailVO> orderResult = new ArrayList<OrderDetailVO>();
		orderResult.add(orderDetail);
		
	
		for (int i = 0; i < orderResult.size(); i++) {
		    OrderDetailVO ordvo = orderResult.get(i);
		    ArrayList<BookVO> dbBook = orderDao.selectOrderBook(orderDetail);
		    ordvo.setOr_title(dbBook.get(i).getBo_title());
		    ordvo.setOr_pay(dbBook.get(i).getBo_price());
		}

		
		
		
		return orderResult;
	}
		

	
}
