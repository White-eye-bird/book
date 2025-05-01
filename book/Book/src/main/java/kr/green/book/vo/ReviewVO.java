package kr.green.book.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data	
public class ReviewVO {
	private int rv_num;
	private String rv_me_id;
	private String rv_title;
	private String rv_review;
	private int rv_rating;
	private Date rv_date;//데이터 타입에 대문자 사용. jsp에서 컨트롤러로 보낼때 415에러발생.
	private String rv_bo_isbn;

	public String getRv_date_str() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd HH:mm");
		return format.format(rv_date);
	}
}
