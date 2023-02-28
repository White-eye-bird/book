package kr.green.book.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class OrderVO {
	private int or_num;
	private String or_me_id;
	private String or_st_state;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date or_date;
	private String or_me_name;
	private String or_receiver_name;
	private String or_phone;
	private String or_addr;
	private String or_addr_detail;
	private String or_message;
	private String or_sum_pay;
	private String or_mileage;
}
