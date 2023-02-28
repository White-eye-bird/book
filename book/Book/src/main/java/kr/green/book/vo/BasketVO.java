package kr.green.book.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BasketVO {
	private int ba_num;
	private String ba_me_id;
	private String ba_bo_isbn;
	private String ba_bo_front;
	private String ba_bo_title;
	private int ba_bo_price;
	private int ba_bo_sale_price;
	private int ba_ea;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date ba_date;
	
	public String getBa_bo_front_url() {
		return "/book/img/" + ba_bo_front;
	}
}
