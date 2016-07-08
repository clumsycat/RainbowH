package cn.ac.ict.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MysqlConnection {
	/**����mysql���ݿ�
	 * @return connection
	 */
	public static Connection getConnection() {
		Connection conn = null;
		try {
			// ��������
			Class.forName("com.mysql.jdbc.Driver");
			// windows ���ݿ�����url
			//String url = "jdbc:mysql://localhost:3306/usertest";
			// linux85 ���������ݿ�����
			 String url="jdbc:mysql://localhost:3306/rainbow";

			// ��ȡ���ݿ�����
			conn = DriverManager.getConnection(url, "root", "vt1111");
			System.out.println("mysql ����");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	/**
	 * �ر����ݿ�����
	 * 
	 * @param conn
	 *            Connection����
	 */
	public static void closeConnection(Connection conn) {
		// �ж�conn�Ƿ�Ϊ��
		if (conn != null) {
			try {
				conn.close(); // �ر����ݿ�����
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
