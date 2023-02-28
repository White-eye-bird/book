package kr.green.book.service;


import java.util.ArrayList;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;

import kr.green.book.dao.BookDAO;
import kr.green.book.pagination.Criteria;
import kr.green.book.utils.UploadFileUtils;
import kr.green.book.vo.BasketVO;
import kr.green.book.vo.BookVO;
import kr.green.book.vo.MemberVO;

@Controller
public class BookServiceImp implements BookService{
	@Autowired
	BookDAO bookDao;
	
	String bookThumbnailUploadPath ="G:\\git\\book";

	@Override
	public void insertbook(BookVO book, MultipartFile file) {
		if(book == null || file == null ||file.getOriginalFilename().length() == 0)
			return; 
		
		try {	// 경로, 파일 원래 이름, 파일 크기 
			String str = UploadFileUtils.uploadFile(bookThumbnailUploadPath, book.getBo_title(), file.getOriginalFilename(), file.getBytes());
			book.setBo_thum(str);
			System.out.println(book);
		} catch (Exception e) {
			e.printStackTrace();
		}
		bookDao.insertBook(book);
	}

	@Override
	public ArrayList<BookVO> getBookList(Criteria cri) {
		return bookDao.selectBook(cri);
	}

	@Override
	public int getTotalCount() {
		return bookDao.selectTotalCount();
	}

	@Override
	public BookVO selectBook(String bo_isbn) {
		if(bo_isbn == null || bo_isbn.length() !=13)
			return null;
		return bookDao.selectBookIsbn(bo_isbn);
	}


	@Override
	public int addBaskitBook(BasketVO basket, MemberVO user) {
			//널값 확인 
			if(basket == null || basket.getBa_bo_isbn() == null )
				return 0; // 장바구니 등록 데이터 전송 오류
			if(user == null)
				return 1; // 로그인 오류 
			BookVO bdBook = bookDao.selectBookIsbn(basket.getBa_bo_isbn());
			
			if(bdBook == null || bdBook.getBo_title()== null)
				return 2;//db에 존재하지 않는 상품
			
			basket.setBa_me_id(user.getMe_id());
			basket.setBa_bo_front(bdBook.getBo_thum());
			basket.setBa_bo_title(bdBook.getBo_title());
			basket.setBa_bo_price(bdBook.getBo_price());
			basket.setBa_bo_sale_price(bdBook.getBo_sale_price());
			
			//중복검사
			BasketVO basketInfo = bookDao.selectFindBaskit(basket);
			
			if(basketInfo != null)
				return 3;//장바구니에 이미 존재하는 상품 
			
			bookDao.insertBaskitBook(basket);
		return 4;
	}

	@Override
	public ArrayList<BasketVO> getBasketBook(MemberVO user) {
		if(user == null)
			return null;
		return bookDao.selectBaskitList(user);
	}

	@Override
	public void updateBaskitBook(BasketVO basket) {
		if(basket == null||basket.getBa_bo_isbn()==null||basket.getBa_me_id() == null)
			return;
		bookDao.updateBasket(basket);
	}

	@Override
	public void deleteBaskitBook(BasketVO basket) {
		if(basket == null||basket.getBa_bo_isbn()==null||basket.getBa_me_id() == null)
			return;
		bookDao.deleteBasket(basket);
	}

	
}
