package com.sist.vo;
/*
 이름        널?      유형
 --------------------------
 NO         NOT NULL NUMBER
 ID         VARCHAR2(20)
 FNO        NUMBER
 */
public class FoodLikeVO {
	private int no,fno;
	private String id;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getFno() {
		return fno;
	}
	public void setFno(int fno) {
		this.fno = fno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
}
