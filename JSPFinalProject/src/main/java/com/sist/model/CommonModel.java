package com.sist.model;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import com.sist.dao.*;
import com.sist.vo.*;
import com.sist.manager.*;
public class CommonModel {
	public static void commonRequestData(HttpServletRequest request) {
		// footer에 들어간다
		FoodDAO dao=FoodDAO.newInstance();
		// => 공지사항 => 최신뉴스
		List<NewsVO> nList=NewsManager.newsSearchData("맛집");
		for(NewsVO vo:nList) {
			String title=vo.getTitle();
			if(title.length()>15) {
				title=title.substring(0,14)+"...";
				vo.setTitle(title);
			}
			vo.setTitle(title);
		}
		request.setAttribute("nList", nList);
		// => 방문맛집
		List<FoodVO> flist=dao.foodTop7();
		request.setAttribute("flist", flist);
	}
}
