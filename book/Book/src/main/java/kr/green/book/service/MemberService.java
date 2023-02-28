package kr.green.book.service;

import kr.green.book.vo.MemberVO;

public interface MemberService {
	public boolean signup(MemberVO member);

	public MemberVO login(MemberVO member);

	public String getId(MemberVO member);

	public boolean findPw(MemberVO member);

	
}
