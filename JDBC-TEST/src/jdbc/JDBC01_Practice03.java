package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBC01_Practice03 {

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
			
			//3. EMP 테이블에 서 “SCOTT” 사원의 급여(sal) 정보를 1000으로 바꾸는 프로그램을 작성	
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
			
			String sql03 = "update emp set sal=1000 where ename='SCOTT'";
			Statement stmt = conn.createStatement();
			int resultCnt = stmt.executeUpdate(sql03);
			if(resultCnt>0) {
				System.out.println(resultCnt+"개의 행에 데이터가 성공적으로 업데이트 되었습니다.");
			}
		
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

}
