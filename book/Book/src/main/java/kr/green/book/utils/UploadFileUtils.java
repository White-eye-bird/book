package kr.green.book.utils;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;

import org.springframework.util.FileCopyUtils;

public class UploadFileUtils {
	
	public static String uploadFile(String uploadPath,String dir, String originalName, byte[]
			fileData)throws Exception{
				String savedName = originalName; // 원래이름을 세이브네임으로 대입 
				//makeDir(uploadPath, dir); //경로에 폴더 생성
				File target = new File(uploadPath, savedName); //파일 객체 생성.
				FileCopyUtils.copy(fileData, target); //파일 카피?? 
				String uploadFileName = makeIcon(uploadPath, "", savedName); //스트링타입으로 바꿔주고 경로
				return uploadFileName;
			}
	
	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		
		String yearPath = File.separator+cal.get(Calendar.YEAR);
		String monthPath = yearPath + File.separator 
            + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		String datePath = monthPath + File.separator 
            + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		makeDir(uploadPath, yearPath, monthPath, datePath);
		
		return datePath;
 
	}
	private static void makeDir(String uploadPath, String... paths) {
		if(new File(paths[paths.length-1]).exists()) // 세이브네임(패치스)의 글자수-1? 폴더존재 확인
			return;
		for(String path : paths) {
			File dirPath = new File(uploadPath + path); //
			if( !dirPath.exists()) //폴더 경로에 존재 하지 않으면 
				dirPath.mkdir();    //이 경로로 폴더 생성
		}
	}
	private static String makeIcon(String uploadPath, String path, String fileName)
        	throws Exception{
		String iconName = uploadPath + path + File.separator + fileName;
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
}
	
