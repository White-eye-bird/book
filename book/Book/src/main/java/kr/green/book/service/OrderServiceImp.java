package kr.green.book.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.book.dao.BookDAO;
import kr.green.book.dao.OrderDAO;
import kr.green.book.vo.BookVO;
import kr.green.book.vo.OrderDetailVO;
import kr.green.book.vo.OrderPageDTO;
import kr.green.book.vo.OrderVO;

@Service	
public class OrderServiceImp implements OrderService{
	@Autowired 
	OrderDAO orderDao; 
	BookDAO	bookDao;
	
	

	//orderVO클래스가서 확인할것
	@Override
	public ArrayList<OrderVO> getOrderBook(OrderVO order) {
			
			ArrayList<BookVO> dbBook = bookDao.selectOrderBook(book);
			//리스트의 값 변경(get index)
			dbBook.get(0).setBo_ea(book.getBo_ea());
			return dbBook;
		}
		

	//240305
	//OrderPageDTO(orders=[OrderDetailVO(or_de_num=0, or_num=0, or_bo_isbn=9788954741255, or_title=null, or_ea=1, or_pay=0), OrderDetailVO(or_de_num=0, or_num=0, or_bo_isbn=9788954741262, or_title=null, or_ea=1, or_pay=0)])
/*
 
	@Override //조건 확인
	public ArrayList<OrderDetailVO> getOrderBook(OrderDetailVO orderDetail) {
		if(orderDetail.getOr_bo_isbn() == null || orderDetail.getOr_bo_isbn().length() !=13 )
			return null;
		if(orderDetail.getOr_ea()<1 || orderDetail.getOr_ea()>200)
			return null;
		
		ArrayList<OrderDetailVO> orderResult = new ArrayList<OrderDetailVO>();
		orderResult.add(orderDetail);
		System.out.println("리설트 리스트에 디테일 추가"+orderResult);
		
	
		for (int i = 0; i < orderResult.size(); i++) {
		    OrderDetailVO ordvo = orderResult.get(i);
		    ArrayList<BookVO> dbBook = orderDao.selectOrderBook(orderDetail);
		    ordvo.setOr_title(dbBook.get(i).getBo_title());
		    ordvo.setOr_pay(dbBook.get(i).getBo_price());
		    System.out.println("포문"+orderResult);
		    
		}
	
		
		
		return orderResult;
	}
		
*/	



	@Override
	public List<OrderDetailVO> getOrderList(OrderPageDTO orderPage) {
    // OrderPageDTO로부터 OrderDetailVO 리스트를 가져옴
    List<OrderDetailVO> orderList = orderPage.getOrders();

    // 결과를 저장할 리스트 생성
    ArrayList<OrderDetailVO> resultList = new ArrayList<OrderDetailVO>();

    // 리스트를 순회하면서 각 OrderDetailVO 객체에 대해 조건 검사
    for (OrderDetailVO orderDetail : orderList) {
        String isbn = orderDetail.getOr_bo_isbn();
        int ea = orderDetail.getOr_ea();

        // ISBN이 null이거나 길이가 13이 아닌 경우
        if (isbn == null || isbn.length() != 13) {
            return null;
        }

        // 주문수량이 1 미만이거나 200 초과인 경우
        if (ea < 1 || ea > 200) {
            return null;
        }

        // ISBN과 주문수량이 유효한 경우, DB에서 책 정보를 가져와 제목과 가격을 설정
        ArrayList<BookVO> dbBook = orderDao.selectOrderBook(orderDetail);
        if (!dbBook.isEmpty()) {
            BookVO book = dbBook.get(0);//여러개의 리스트가 검색될 경우 DB 첫번째 리스트(첫번째 리스트의 타이틀, 가격 등)를 변수에서 넣는다. 
            orderDetail.setOr_title(book.getBo_title());
            //orderDetail.setOr_pay(book.getBo_price());
            orderDetail.setOr_pay(book.getBo_price()*orderDetail.getOr_ea());
            
            //확인용
            System.out.println(orderDetail);
            
            // 결과 리스트에 추가
            resultList.add(orderDetail);
        }
    }

    // 결과 리스트 반환
    return resultList;

	}


	@Override
	public ArrayList<OrderDetailVO> getOrderBook(OrderDetailVO orderDetail) {
		// TODO Auto-generated method stub
		return null;
	}
		
}
