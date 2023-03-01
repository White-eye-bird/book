package kr.green.book.vo;

import lombok.Data;

@Data
public class OrderDetailVO {
	private int or_de_num;
	private int or_num;
	private String or_bo_isbn;
	private String or_title;
	private int or_ea;
	private int or_pay;
	
}
