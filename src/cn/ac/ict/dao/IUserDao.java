package cn.ac.ict.dao;

import cn.ac.ict.domain.*;
public interface IUserDao {

	/**
	 * 根据用户名和密码去查找用户
	 * @param userName
	 * @param userPwd
	 * @return 查找到的用户
	 */
	User find(String userName, String userPwd);
	
	/**
	 * 根据用户名查找用户
	 * @param userName
	 * @return 查找到的用户
	 */
	User find(String userName);
	
	/**
	 * 添加用户
	 * @param user
	 */
	void add(User user);
}
