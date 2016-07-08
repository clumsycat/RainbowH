package cn.ac.ict.service;

import cn.ac.ict.domain.User;
import cn.ac.ict.exception.UserExistException;

public interface IUserService {

	/**
	 * �ṩע�����
	 * @param user
	 *            ֻ��д��user����
	 * @throws UserExistException
	 */
	void registerUser(User user) throws UserExistException;

	/**
	 * �ṩ��¼����
	 * @param userName
	 * @param userPwd
	 * @return
	 */
	User loginUser(String userName, String userPwd);
}
