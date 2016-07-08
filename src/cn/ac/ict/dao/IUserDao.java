package cn.ac.ict.dao;

import cn.ac.ict.domain.*;
public interface IUserDao {

	/**
	 * �����û���������ȥ�����û�
	 * @param userName
	 * @param userPwd
	 * @return ���ҵ����û�
	 */
	User find(String userName, String userPwd);
	
	/**
	 * �����û��������û�
	 * @param userName
	 * @return ���ҵ����û�
	 */
	User find(String userName);
	
	/**
	 * ����û�
	 * @param user
	 */
	void add(User user);
}
