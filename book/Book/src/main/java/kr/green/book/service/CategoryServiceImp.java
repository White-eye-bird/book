package kr.green.book.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.book.dao.CategoryDAO;
import kr.green.book.vo.CategoryDTO;
import kr.green.book.vo.CategoryVO;

@Service
public class CategoryServiceImp implements CategoryService{

	@Autowired
	CategoryDAO categoryDao;

	@Override
	public boolean insertCategory(CategoryVO category) {
		System.out.println(category);
		if(category == null)
			return false;
		//소분류등록
		if(category.getSm_me_code() != 0)
			categoryDao.insetSmallCategory(category);
		//중분류 등록
		else if(category.getMe_la_code() !=0)
			categoryDao.insetMediumCategory(category);
		else
			categoryDao.insetLargeCategory(category);
			
		return true;
	}



	@Override
	public ArrayList<CategoryVO> getCategoryList(CategoryDTO cvo) {
		if(cvo == null )
			return null;
		if(cvo.getTb_name().equals("large_category"))
			return categoryDao.getLargeCategoryList();
		if(cvo.getTb_name().equals("medium_category"))
			return categoryDao.getMediumCategoryList(cvo.getCode());
		return categoryDao.getSmallCategoryList(cvo.getCode());
	}
}