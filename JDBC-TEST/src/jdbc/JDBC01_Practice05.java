package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBC01_Practice05 {

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
			
			//3. 모든 사원정보를 출력하되 부서정보를 함께 출력하는 프로그램을 작성해보자.
			
			String sql05 = "select * from emp e join dept d using (deptno) order by deptno";
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql05);
			
			while(rs.next()) {
				int deptno =  rs.getInt(1);
				int empno =  rs.getInt(2);
				String ename = rs.getString(3);
				String job = rs.getString(4);
				int mgr = rs.getInt(5);
				String hiredate = rs.getString(6);
				int sal = rs.getInt(7);
				int comm = rs.getInt(8); 
				String dname = rs.getString(9);
				String loc = rs.getString(10);
				
				System.out.println("부서번호||사원번호||사원이름|| 직무  || 상관번호  ||  입사일  ||   급여   || 커미션  || 부서이름  || 부서지역");
				System.out.println(deptno+"||"+empno+"||"+ename+"||"+job+"||"+mgr+"||"+hiredate+"||"+sal+"||"+comm+"||"+dname+"||"+loc);
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
