package kr.green.book.vo;

import lombok.Data;

@Data
public class MemberVO {
	private String me_id;
	private String me_name;
	private String me_email;
	private String me_pw;
	private String me_phone;
	private String me_post_code;
	private String me_addr;
	private String me_addr_detail;
	private String me_extend_years;
	private int me_authority;
	private int me_mileage;
}
