package kr.green.book.vo;

import lombok.Data;

@Data
public class FileVO {
	private int fi_num;//PK AI
	private String fi_ori_name;
	private String fi_name;
	private String fi_table;
	private int fi_bd_num;
	
	public FileVO(String fi_ori_name, String fi_name) {
		this.fi_ori_name = fi_ori_name;
		this.fi_name = fi_name;
	}
}
