package com.sist.vo;
/*
 이름                                      널?      유형
 ----------------------------------------- -------- ----------------------------
 RNO                                       NOT NULL NUMBER
 RDAY                                      NOT NULL NUMBER
 TIME                                      NOT NULL VARCHAR2(200)
 */
public class ReserveDayVO {
	private int rno,rday;
	private String time;
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public int getRday() {
		return rday;
	}
	public void setRday(int rday) {
		this.rday = rday;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
}
