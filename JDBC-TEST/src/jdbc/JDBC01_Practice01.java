package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBC01_Practice01 {

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
			
			//3. executeUpdate 이용해서 EMP 테이블에 새로운 사원 정보를 입력하는 프로그램을 작성 
			
/*			이름       널?       유형           
			-------- -------- ------------ 
			EMPNO    NOT NULL NUMBER(4)    
			ENAME             VARCHAR2(10) 
			JOB               VARCHAR2(9)  
			MGR               NUMBER(4)    
			HIREDATE          DATE         
			SAL               NUMBER(7,2)  
			COMM              NUMBER(7,2)  
			DEPTNO            NUMBER(2)    
*/
			String sql01 = "insert into emp values (?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement pstmt = conn.prepareStatement(sql01);
			
			pstmt.setInt(1, 8000);
			pstmt.setString(2, "MINHEE");
			pstmt.setString(3, "CEO");
			pstmt.setInt(4, 1234);
			pstmt.setString(5, "19/11/10");
			pstmt.setInt(6, 10000);
			pstmt.setInt(7, 1000);
			pstmt.setInt(8, 30);
			
			int resultCnt = pstmt.executeUpdate();
			if(resultCnt>0) {
				System.out.println(resultCnt+"개의 행에 데이터가 성공적으로 업데이트 되었습니다.");
			}
						
			pstmt.close();
			conn.close();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

}
