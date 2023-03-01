package kr.green.book.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.green.book.vo.BookVO;
import kr.green.book.vo.OrderDetailVO;

public interface OrderDAO {

	ArrayList<BookVO> selectOrderBook(@Param("or")OrderDetailVO orderDetail);

	

}
