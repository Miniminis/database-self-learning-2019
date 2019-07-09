package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCConnection01_mysql {

	public static void main(String[] args) {
		
		//1. 데이터 베이스에 드라이버를 로드한다. 
		//2. 데이터 베이스 연결 
		
		Connection conn = null; //밑에 메서드 안에서 처리되므로 초기화 필요!  
		
		//2-0. JDBC_URL: 
		String jdbcUrl = "jdbc:mysql://localhost:3306/project?serverTimezone=UTC";	
		
		//2-0. USER 
		String user = "bit";
		
		//2-0. PASSWORD 
		String password = "bit";
		
		
		try {
			
			//1. 데이터 베이스에 드라이버를 로드한다. 
			Class.forName("com.mysql.jdbc.Driver");
			
			//2. 데이터 베이스 연결
			conn = DriverManager.getConnection(jdbcUrl, user, password);
			System.out.println("데이터베이스 연결 성공!");
			
			//////////데이터 베이스 작업 단계//////////
			
			//3. 데이터 베이스의 연결 종료: 데이터 베이스 작업 종료 후
			conn.close();
			
		} catch (ClassNotFoundException e) {
			// 드라이버가 저장된 클래스를 찾지 못할 때 발생하는 에러 처리 
			e.printStackTrace();
		} catch (SQLException e) {
			// 데이터 베이스 연결 과정에서 발생할 수 있는 에러 처리 
			e.printStackTrace();
		} 
		
		/* The server time zone value */
	}

}
