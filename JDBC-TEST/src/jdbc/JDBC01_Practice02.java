package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBC01_Practice02 {

	public static void main(String[] args) {
		
		//2-0
		Connection conn = null;
		
		//2-0. JDBC_URL: 
		String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:orcl";	
		
		//2-0. USER 
		String user = "SCOTT";
		
		//2-0. PASSWORD 
		String password = "tiger";
		
		try {
			//1. 데이터베이스 드라이브 로드
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			//2. 데이터베이스 연결 
			conn = DriverManager.getConnection(jdbcUrl, user, password);
			//연결되었으면 성공메시지 출력!
			System.out.println("데이터베이스에 성공적으로 연결되었습니다!");
			
			//3. EMP 테이블의 모든 데이터를 출력하는 프로그램을 작성 	
					
			String sql02 = "select * from emp";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql02);
			
			while(rs.next()) {
				int empno =  rs.getInt(1);
				String ename = rs.getString(2);
				String job = rs.getString(3);
				int mgr = rs.getInt(4);
				String hiredate = rs.getString(5);
				int sal = rs.getInt(6);
				int comm = rs.getInt(7); 
				int deptno = rs.getInt(8);
				
				System.out.println("사원번호 || 사원이름|| 직무  || 상관번호  ||  입사일  ||   급여   || 커미션  || 부서번호");
				System.out.println(empno+"||"+ename+"||"+job+"||"+mgr+"||"+hiredate+"||"+sal+"||"+comm+"||"+deptno);
				System.out.println("============================================================");
			}
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
