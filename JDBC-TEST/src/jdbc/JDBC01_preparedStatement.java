package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBC01_preparedStatement {

	public static void main(String[] args) {
		
		//데이터 베이스의 사이클 
		//1. 데이터베이스 드라이버 로드 
		//2. 데이터베이스 연결 
		//3. Statement 객체 생성 
		//4. SQL 실행: executeQuery() - SELECT / executeUpdate() - INSERT/ UPDATE/ DELETE 
		//5. 결과 출력 
		//6. 사용 객체 close() - ResultSet.close(), Statement.close(), Connection.close() 
		
		Connection conn = null;
		
		//2-0. JDBC_URL: 
		String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:orcl";	
		
		//2-0. USER 
		String user = "SCOTT";
		
		//2-0. PASSWORD 
		String password = "tiger";
		
		try {
			//1. 데이터베이스 드라이버 로드 
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			//2. 데이터베이스 연결 
			conn = DriverManager.getConnection(jdbcUrl, user, password);
			System.out.println("오라클 데이터베이스에 접속하였습니다! ");
			
			//3. PreparedStatement 객체 생성: sql 문 --> pstmt 객체생성(sql대입) --> 데이터삽입 --> executeUpdate(); 
			
			  String sql02 = "insert into emp01 values(?, ?, ?, ?, ?, ?, ?, ?)";
			  PreparedStatement pstmt = conn.prepareStatement(sql02);
			  
			  pstmt.setInt(1, 8000); 
			  pstmt.setString(2, "MINHEE"); 
			  pstmt.setString(3,"CEO"); 
			  pstmt.setInt(4, 0000); 
			  pstmt.setString(5, "19/11/10");
			  pstmt.setInt(6, 9000); 
			  pstmt.setInt(7, 1000); 
			  pstmt.setInt(8, 60);
			  
			  int resultCnt = pstmt.executeUpdate();
			  
			  if(resultCnt>0) { 
				  System.out.println(resultCnt+"개의 행에 데이터가 정상적으로 입력되었습니다. ");
			  }
			 
			
			  
			Statement stmt = conn.createStatement();
			
			String sql01 = "select * from emp01 order by empno";
			ResultSet rs = stmt.executeQuery(sql01);
			
			while(rs.next()) {
				
				int empno = rs.getInt(1);
				String ename = rs.getString(2);
				String job = rs.getString(3);
				int mgr = rs.getInt(4);
				String hiredate = rs.getString(5);
				int sal = rs.getInt(6);
				int comm = rs.getInt(7);
				int deptno = rs.getInt(8);
				
				System.out.println(empno+"||"+ename+"||"+job+"||"+mgr+"||"+hiredate+"||"+sal+"||"+comm+"||"+deptno);
				System.out.println("==================================================================");
				
			};
			rs.close();
			//pstmt.close();
			stmt.close();
			conn.close();			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
}

/* 결과: 
 * 오라클 데이터베이스에 접속하였습니다! 
 * 10||ACCOUNTING||NEW YORK 
 * ========================
 * 20||RESEARCH||DALLAS 
 * ======================== 
 * 30||SALES||CHICAGO
 * ======================== 
 * 40||OPERATIONS||BOSTON 
 * ========================
 */