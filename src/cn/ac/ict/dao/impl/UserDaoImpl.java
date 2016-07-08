package cn.ac.ict.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import cn.ac.ict.dao.*;
import cn.ac.ict.domain.*;

public class UserDaoImpl implements IUserDao {

	@Override
	public User find(String userName, String userPwd) {
		// TODO 自动生成的方法存根
		Connection conn=MysqlConnection.getConnection();
		String sql = "select * from users where name=\""
				+ userName + "\" and password=\"" + userPwd + "\"";
		User user = new User();
		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);

			while (rs.next()) {
				user.setId(rs.getObject("id").toString());
				user.setUserName(rs.getObject("name").toString());
				user.setUserPwd(rs.getObject("password").toString());
				user.setEmail(rs.getObject("email").toString());
				user.setGroup(rs.getObject("group").toString());
			}
			rs.close();
			st.close();
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}finally{

			MysqlConnection.closeConnection(conn);
		}
		return user;
	}

	@Override
	public User find(String userName) {
		// TODO 自动生成的方法存根
		Connection conn=MysqlConnection.getConnection();
		String sql = "select id,name,password,email from users where name=\""
				+ userName + "\"";
		User user = new User();
		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			while (rs.next()) {
				user.setId(rs.getObject("id").toString());
				user.setUserName(rs.getObject("name").toString());
				user.setUserPwd(rs.getObject("password").toString());
				user.setEmail(rs.getObject("email").toString());
				user.setGroup(rs.getObject("group").toString());
			}
			rs.close();
			st.close();
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}finally{
			MysqlConnection.closeConnection(conn);
		}
		return user;
	}

	@Override
	public void add(User user) {
		// TODO 自动生成的方法存根
		Connection conn=MysqlConnection.getConnection();
		String sql = "insert into users(`name`,`password`,`email`,`group`) values(?,?,?,?)";
				
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserName());
			ps.setString(2, user.getUserPwd());
			ps.setString(3, user.getEmail());
			ps.setString(4, user.getGroup());
			int i=ps.executeUpdate();//i=1时，成功插入
			ps.close();
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}finally{
			MysqlConnection.closeConnection(conn);
		}
	}

}
