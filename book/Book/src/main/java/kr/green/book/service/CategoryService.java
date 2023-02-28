package kr.green.book.service;

import java.util.ArrayList;

import kr.green.book.vo.CategoryDTO;
import kr.green.book.vo.CategoryVO;

public interface CategoryService {

	boolean insertCategory(CategoryVO category);

	ArrayList<CategoryVO> getCategoryList(CategoryDTO cvo);

}
