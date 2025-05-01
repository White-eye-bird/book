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
import kr.green.book.vo.ReviewVO;

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
	public int getTotalCount(Criteria cri) {
		if(cri == null)
			return 0;
		return bookDao.selectTotalCount(cri);
		
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

	@Override
	public String insertReviwe(ReviewVO review, MemberVO user) {
		//유효성검사들
		//유저 객체가 없어거나 아이디가 존재 안하면 리턴
		if(user==null)
			return "로그인한 사용자만 작성할 수 있습니다.";
		//리뷰가 없으면 리턴
		if(review==null||review.getRv_review()== null)
			return "내용이 없습니다.";
		//책정보가 없다면 리턴
		if(review.getRv_bo_isbn()== null)
			return "잘못된 도서 정보입니다. 리뷰를 작성할 수 없습니다. ";
		//도서를 DB검색해서 있는지 확인하기
		BookVO dbCheckBook = bookDao.selectBookIsbn(review.getRv_bo_isbn());
		if(dbCheckBook == null || dbCheckBook.getBo_isbn().length() !=13)
			return "잘못된 도서 정보입니다. 리뷰를 작성할 수 없습니다.";
				
		review.setRv_me_id(user.getMe_id());
		bookDao.reviewInsert(review);

		return "리뷰를 등록했습니다.";
	}
	/*책 리뷰 가져오기*/
	@Override
	public ArrayList<ReviewVO> getReview(String bo_isbn, Criteria cri) {
		if(cri == null)
			return null;
		
		return bookDao.selectReviewList(bo_isbn, cri);
	}
  /*페이지 네이션 구현, 페이지메이커 토탈 리뷰 개수 구하기 */
	@Override
	public int getTotalCountList(String bo_isbn) {
		return bookDao.selectTotalCountList(bo_isbn);
	}

	
}
