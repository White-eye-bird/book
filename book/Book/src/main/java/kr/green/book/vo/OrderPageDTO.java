package kr.green.book.vo;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
@Data
//ToString //orders 필드의 상태를 출력하도록 
@NoArgsConstructor
public class OrderPageDTO {
//OrderPageDTD는 OrderDetailVO를 객채로 가지는 클래스
	private List<OrderDetailVO> orders;

	public void setOrders(List<OrderDetailVO> orders) {
		System.out.println("setOrders called");
		this.orders = orders;
		
	}


}
