package com.sist.dao;
import java.sql.*;
import java.util.*;
import com.sist.vo.*;
/*
 * << 오라클 연결 과정 >>
 * 1. 드라이버 등록
 *    ----- 오라클을 연결하는 라이브러리(ojdbc.8.jar)
 *    OracleDriver => 메모리 할당 해야 동작 가능
 * 2. 오라클 연결
 *    Connection
 * 3. SQL문장 전송
 *    PreparedStatement
 * 4. SQL문장 실행 요청
 *    executeUpdate() : INSERT, UPDATE, DELETE
 *    --------------- COMMIT(AutoCommit)
 *    executeQuery() : SELECT
 *    ------------- > 검색한 결과값을 가져온다
 *                         ---- ResultSet
 *    
 *    ex) String sql="SELECT id,name,sex,age";
 *    ResultSet
 *    -----------------------------------
 *       id     name     sex     age
 *    -----------------------------------
 *      aaa     홍길동     남자     20     | first() => next()
 *                                    처음으로 위치변경   위치변경 후 데이터 읽기
 *  getString(1) getString(2) getString(3) getInt(4) --> 컬럼명 사용도 가능 getString("id")
 *    -----------------------------------
 *      bbb     심청이     여자     23
 *  getString(1) getString(2) getString(3) getInt(4)
 *    -----------------------------------
 *      ccc     박문수     남자     27     | last() => previous()
 *                                        마지막으로 위치변경
 *  getString(1) getString(2) getString(3) getInt(4)  <---- while 문안에서 사용하쟈냐
 *    -----------------------------------
 *     | <- 커서 위치
 * 5. 닫기
 *    생성 반대로 닫는다
 *    rs.close(), ps.close(), conn.close()
 */
public class FoodDAO {
	// 기능 => INSERT => 데이터수집(파일)
	private Connection conn; // 오라클 연결 객체(데이터베이스 연결)
	private PreparedStatement ps; //SQL 문장 전송 / 결과값 읽기
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	// MySQL => jdbc:mysql://locashost(서버주소)/mydb
	private static FoodDAO dao; // 싱글턴 패턴
	// DAO객체를 한개만 사용이 가능하게 만든다
	// 드라이버 설치 => 소프트웨어 (메모리 할당 요청) Class.forname()
	// 클래스의 정보를 전송
	// 드라이버 설치는 1번만 수행 -> 생성자
	public FoodDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch(Exception ex) {}
	}
	// 오라클 연결
	public void getConnection() {
		try {
			conn=DriverManager.getConnection(URL,"hr","happy");
			// getConnection을 실행하면 conn hr/happy <- 이 명령이 오라클로 전송되는 것
		}catch(Exception ex) {}
	}
	// 오라클 연결 종료
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
			// disConnection을 실행하면 exit 가 오라클로 전송된다
		}catch(Exception ex) {}
	}
	// DAO객체를 하나만 생성해서 사용 => 메모리 누수현상을 방지(싱글턴 패턴)
	public static FoodDAO newInstance() {
		//newInstance(), getInstance() => 싱글턴
		if(dao==null)
			dao=new FoodDAO(); // (if문) 생성이 되어있으면 생성된걸 쓰고, 생성되지 않아있으면 생성을 해라
		return dao;
	}
	// 여기까지가 모든 DAO의 기본 셋팅
	// 기능
	// 1. 데이터 수집(INSERT)
	/*
	 * Statement => SQL 생성과 동시에 데이터 추가 => "'"+name+"','"+age+"'.'" ... 
	 * PreparedStatement => 미리 SQL문장을 만들어 두고, 나중에 값을 채워주는 형식
	 * -> default
	 * CallableStatement => procedure호출
	 */
	public void foodCategoryInsert(CategoryVO vo) {
		try {
			// 1. 연결
			getConnection();
			// 2. SQL문장 생성
			String sql="INSERT INTO food_category VALUES(fc_cno_seq.nextval,?,?,?,?)";
			/*
			 *  "'"+vo.getTitle+"','"
			 */
			// 3. SQL문장 오라클에 전송
			ps=conn.prepareStatement(sql);
			// 3-1. ? 에 값을 채운다
			ps.setString(1, vo.getTitle()); //  "'"+vo.getTitle+"','" <- 자동으로 이렇게 된다
			ps.setString(2, vo.getSubject());
			ps.setString(3, vo.getPoster());
			ps.setString(4, vo.getLink());
			// 오류 => 번호가 잘못되면 오류(? 갯수와 같아야함) , 데이터형이 다르면 오류
			// IN,OUT ~
			// 4. SQL문장 실행 명령 => SQL문장을 작성하고
			ps.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			disConnection(); // 오라클 연결 해제 => 무조건
		}
	}
	// 1-1. 실제 맛집 정보 저장
	/*
	fno NUMBER,
	cno NUMBER,
	name VARCHAR2(100) CONSTRAINT fh_name_nn NOT NULL,
	score NUMBER(2,1) , -- 평점 없는게 있으니까 nn 안돼
	address VARCHAR2(300) CONSTRAINT fh_addr_nn NOT NULL,
	phone VARCHAR2(20) CONSTRAINT fh_phone_nn NOT NULL,
	type VARCHAR2(30) CONSTRAINT fh_type_nn NOT NULL,
	price VARCHAR2(30),
	parking VARCHAR2(30),
	time VARCHAR2(20),
	menu CLOB,
	good NUMBER,
	soso NUMBER,
	bad NUMBER,
	poster VARCHAR2(4000) CONSTRAINT fh_poster_nn NOT NULL
	 */
	public void foodDataInsert(FoodVO vo) {
		try {
			// 1.오라클 연결
			getConnection();
			// 2.sql문장 제작
			String sql="INSERT INTO food_house VALUES(fh_fno_seq.nextval,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			// 3. 오라클 전송
			ps=conn.prepareStatement(sql);
			// 4. ? 값 채운다
			ps.setInt(1, vo.getCno());
			ps.setString(2, vo.getName());
			ps.setDouble(3, vo.getScore());
			ps.setString(4, vo.getAddess());
			ps.setString(5, vo.getPhone());
			ps.setString(6, vo.getType());
			ps.setString(7, vo.getPrice());
			ps.setString(8, vo.getParking());
			ps.setString(9, vo.getTime());
			ps.setString(10, vo.getMenu());
			ps.setInt(11, vo.getGood());
			ps.setInt(12, vo.getSoso());
			ps.setInt(13, vo.getBad());
			ps.setString(14, vo.getPoster());
			
			// 실행요청
			ps.executeUpdate(); // AutoCommit()
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			disConnection();// 오라클 연결 해제 => 무조건
		}
	}
	// 2. SELECT => 전체 데이터 읽기 => 30개(한개당 => CategoryVO)
	// Collection, 배열 => 묶어서 브라우저로 30개를 전송 => 브라우저에서 출력
	// 브라우저 <=X=> 오라클 --> 브라우저 <==> 자바 <==> 오라클 => Spring Cloud // 그래서 자바 배우는거임
	// 이부분은 Collection , 메소드 제작(리턴형, 매개변수) 공부
	public List<CategoryVO> foodCategoryData(){ // 데이터를 모아서 온다 -> List
		List<CategoryVO> list=new ArrayList<CategoryVO>();
		try {
			// 1. 오라클 연결
			getConnection();
			// 2. SQL문장 만들기
			String sql="SELECT cno,title,subject,poster,link  "
					+ "FROM food_category";
			// 3.오라클로 전송
			ps=conn.prepareStatement(sql);
			// 4. 실행 후 결과값 받기
			ResultSet rs=ps.executeQuery();
			// rs에 있는 데이터를 list에 저장
			while(rs.next()) {
				CategoryVO vo=new CategoryVO();
				vo.setCno(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				vo.setSubject(rs.getString(3));
				String poster=rs.getString(4);
				poster=poster.replace("#","&");
				vo.setPoster(poster);
				vo.setLink("https://www.mangoplate.com"+rs.getString(5));
				list.add(vo);
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		finally {
			// 오라클 닫기
			disConnection();
		}
		return list;
	}
	// 3. 상세보기 => WHERE
	
}
