package kr.green.book.dao;

import org.apache.ibatis.annotations.Param;

import kr.green.book.vo.MemberVO;

public interface MemberDAO {
	public MemberVO selectMember(@Param("me_id") String me_id);

	public void insertMember(@Param("m") MemberVO member);

	public String selectId(@Param("m")MemberVO member);

	public void updateMember(@Param("m")MemberVO user);
}
