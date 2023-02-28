package kr.green.book.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.book.dao.BookDAO;
import kr.green.book.vo.OrderVO;

@Service	
public class OrderServiceImp implements OrderService{
	@Autowired 
	BookDAO bookDao; 
	
	@Override
	public ArrayList<OrderVO> getOrderBook(OrderVO order) {
		// TODO Auto-generated method stub
		return null;
	}
/*
	@Override
	public ArrayList<OrderVO> getOrderBook(OrderVO order) {
			if(order.getBo_isbn() == null || order.getBo_isbn().length() !=13 )
				return null;
			if(book.getBo_ea()<1 || book.getBo_ea()>200)
				return null;
			ArrayList<BookVO> dbBook = bookDao.selectOrderBook(book);
			//리스트의 값 변경(get index)
			dbBook.get(0).setBo_ea(book.getBo_ea());
			return dbBook;
		}
		
		*/
		

	
}
