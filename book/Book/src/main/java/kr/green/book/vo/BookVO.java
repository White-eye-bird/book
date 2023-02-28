package kr.green.book.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BookVO {
	private String bo_isbn;
	private int bo_ca_code;
	private String bo_thum;
	private String bo_title;
	private String bo_publisher;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date bo_date;
	private int bo_price;
	private int bo_sale_price;
	private int bo_ea;
	private String bo_author;
	private String bo_translator;
	private String bo_detail_page;
	private String bo_detail_size;
	private String bo_detail_weight;
	private String bo_intro;
	private String bo_index;
	
	public String getBo_date_str() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return format.format(bo_date);
	}
	public String getBo_date_ymstr() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy년 MM월");
		return format.format(bo_date);
	}
	public String getBo_thum_url() {
		return "/book/img/" + bo_thum;
	}
}
