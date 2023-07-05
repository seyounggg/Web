package com.sist.model;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import com.sist.dao.*;
import com.sist.vo.*;
public class CommonModel {
	public static void commonRequestData(HttpServletRequest request) {
		// footer에 들어간다
		FoodDAO dao=FoodDAO.newInstance();
		// => 공지사항 => 최신뉴스
		// => 방문맛집
		List<FoodVO> flist=dao.foodTop7();
		request.setAttribute("flist", flist);
	}
}
