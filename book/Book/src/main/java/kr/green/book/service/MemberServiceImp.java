package kr.green.book.service;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.green.book.dao.MemberDAO;
import kr.green.book.vo.MemberVO;

@Service
public class MemberServiceImp implements MemberService{
	@Autowired
	MemberDAO memberDao;
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	@Autowired
	JavaMailSender mailSender;
	
	@Override
	public boolean signup(MemberVO member) {
		if(member == null)
			return false;
			
		if(member.getMe_id() == null || member.getMe_pw() == null ||
			 member.getMe_name() == null || member.getMe_email() == null || 
			 member.getMe_phone() == null || member.getMe_extend_years() == null)
			return false;
		
		MemberVO dbMember = memberDao.selectMember(member.getMe_id());
			
		if(dbMember != null)
			return false;
		
		//비밀번호 암호화
		String encPw = passwordEncoder.encode(member.getMe_pw());
		member.setMe_pw(encPw);
		
		memberDao.insertMember(member);
		return true;
	}

	@Override
	public MemberVO login(MemberVO member) {
		if(member == null || member.getMe_id() == null)
			return null;

		MemberVO user = memberDao.selectMember(member.getMe_id());

		if(user == null)
			return null;
		
		//암호화된 비번일치 확인
		if(passwordEncoder.matches(member.getMe_pw(),user.getMe_pw()))
			return user;

		return null;
	}

	@Override
	public String getId(MemberVO member) {
		
		if(member== null || member.getMe_email() == null ||member.getMe_phone() == null)
			return null;
	
		return memberDao.selectId(member);
	}

	@Override
	public boolean findPw(MemberVO member) {
		if(member == null || member.getMe_id() == null|| member.getMe_phone() == null)
			return false;
		
		String id =  memberDao.selectId(member);
		
		if(id == null)
			return false;
		
		MemberVO user = memberDao.selectMember(id);
		
		
		String str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		String newPw ="";
		
		
		for(int i = 1; i<8; i++) {
			int r = (int)(Math.random()*str.length());
			newPw += str.charAt(r);
		}
		
		String encPW = passwordEncoder.encode(newPw);
		user.setMe_pw(encPW);
		
		memberDao.updateMember(user);
		
		
		String title = "새 비밀번호가 발급됐습니다.";
		String content = "새 비밀번호는 <br>"+ newPw +"</br>입니다.";
		
		return sendEmail(user.getMe_email(),title,content);
	}

	public boolean sendEmail(String to, String title, String content) {

	    try {
	        MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper messageHelper 
	            = new MimeMessageHelper(message, true, "UTF-8");

	        messageHelper.setFrom("aa@gamil.com");  // 보내는사람 생략하거나 하면 정상작동을 안함
	        messageHelper.setTo(to);     // 받는사람 이메일
	        messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
	        messageHelper.setText(content,true);  // 메일 내용

	        mailSender.send(message);
	    } catch(Exception e){
	    	e.printStackTrace();
	    	return false;
	    }
	    return true;
		
	}
}
