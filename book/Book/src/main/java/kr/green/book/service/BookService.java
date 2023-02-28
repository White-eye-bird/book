package kr.green.book.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import kr.green.book.pagination.Criteria;
import kr.green.book.vo.BasketVO;
import kr.green.book.vo.BookVO;
import kr.green.book.vo.MemberVO;
import kr.green.book.vo.OrderVO;

public interface BookService {

	void insertbook(BookVO book, MultipartFile file);

	ArrayList<BookVO> getBookList(Criteria cri);

	int getTotalCount();

	BookVO selectBook(String bo_isbn);

	int addBaskitBook(BasketVO basket, MemberVO user);

	ArrayList<BasketVO> getBasketBook(MemberVO user);

	void updateBaskitBook(BasketVO basket);

	void deleteBaskitBook(BasketVO basket);
	
	

	

	

}
