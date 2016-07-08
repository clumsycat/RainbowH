package cn.ac.ict.service;

import cn.ac.ict.domain.User;
import cn.ac.ict.exception.UserExistException;

public interface IUserService {

	/**
	 * 提供注册服务
	 * @param user
	 *            只需写入user即可
	 * @throws UserExistException
	 */
	void registerUser(User user) throws UserExistException;

	/**
	 * 提供登录服务
	 * @param userName
	 * @param userPwd
	 * @return
	 */
	User loginUser(String userName, String userPwd);
}
