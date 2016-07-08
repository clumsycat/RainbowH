package cn.ac.ict.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MysqlConnection {
	/**连接mysql数据库
	 * @return connection
	 */
	public static Connection getConnection() {
		Connection conn = null;
		try {
			// 加载驱动
			Class.forName("com.mysql.jdbc.Driver");
			// windows 数据库连接url
			//String url = "jdbc:mysql://localhost:3306/usertest";
			// linux85 机器上数据库连接
			 String url="jdbc:mysql://localhost:3306/rainbow";

			// 获取数据库连接
			conn = DriverManager.getConnection(url, "root", "vt1111");
			System.out.println("mysql 链接");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	/**
	 * 关闭数据库连接
	 * 
	 * @param conn
	 *            Connection对象
	 */
	public static void closeConnection(Connection conn) {
		// 判断conn是否为空
		if (conn != null) {
			try {
				conn.close(); // 关闭数据库连接
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
