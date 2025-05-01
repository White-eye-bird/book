package kr.green.book.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.green.book.pagination.Criteria;
import kr.green.book.vo.BasketVO;
import kr.green.book.vo.BookVO;
import kr.green.book.vo.MemberVO;
import kr.green.book.vo.OrderDetailVO;
import kr.green.book.vo.ReviewVO;

public interface BookDAO {

	void insertBook(@Param("bo")BookVO book);

	ArrayList<BookVO> selectBook(@Param("cri") Criteria cri);

	int selectTotalCount(@Param("cri") Criteria cri);

	BookVO selectBookIsbn(String bo_isbn);

	ArrayList<BookVO> selectOrderBook(@Param("bo") BookVO book);

	void insertBaskitBook(@Param("ba") BasketVO basket);

	ArrayList<BasketVO> selectBaskitList(@Param("me") MemberVO user);

	void updateBasket(@Param("ba") BasketVO basket);

	void deleteBasket(@Param("ba") BasketVO basket);

	/*장바구니 중복검사*/
	BasketVO selectFindBaskit(@Param("ba")BasketVO basket);

	/*리뷰 등록*/
	void reviewInsert(@Param("rv")ReviewVO review);

	ArrayList<ReviewVO> selectReviewList(@Param("bo_isbn")String bo_isbn, @Param("cri") Criteria cri);

	int selectTotalCountList(@Param("bo_isbn")String bo_isbn);

	

	

	



}
