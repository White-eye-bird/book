package kr.green.book.vo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
public class OrderDetailVO {
	private int or_de_num; 
	private int or_num;
	private String or_bo_isbn; // 뷰에서 받을것 
	private String or_title; //DB에서 받을 값
	private int or_ea; // 뷰에서 받을것 
	private int or_pay; //DB에서 받을 값
}
