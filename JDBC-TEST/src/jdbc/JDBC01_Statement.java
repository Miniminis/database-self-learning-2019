package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBC01_Statement {

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
			
			//3. Statement 객체 생성 
			Statement stmt = conn.createStatement();
			
			String sql01 = "select * from dept order by deptno";
			ResultSet rs = stmt.executeQuery(sql01);
			
			while(rs.next()) {
				
				int deptno = rs.getInt("deptno");
				String dname = rs.getString("dname");
				String loc = rs.getString("loc");
				
				System.out.println(deptno+"||"+dname+"||"+loc);
				System.out.println("========================");
				
				//or 컬럼의 index 값으로 가져오기: 테이블 순서대로 1, 2, 3.... 
				//int deptno = rs.getInt(1);
				//String dname = rs.getString(2);
				//String loc = rs.getString(3);
			};
			rs.close();
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