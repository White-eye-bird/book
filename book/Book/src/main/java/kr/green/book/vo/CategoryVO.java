package kr.green.book.vo;

import lombok.Data;

/*대중소 분류를 병합*/
@Data
public class CategoryVO {
	private int la_code;
	private int me_code;
	private int me_la_code;
	private int sm_code;
	private int sm_me_code;
	private String la_name;
	private String me_name;
	private String sm_name;
	
	public CategoryVO() {}
}
