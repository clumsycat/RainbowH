package cn.ac.ict.service.impl;

import cn.ac.ict.dao.IUserDao;
import cn.ac.ict.dao.impl.UserDaoImpl;
import cn.ac.ict.domain.User;
import cn.ac.ict.exception.UserExistException;
import cn.ac.ict.service.IUserService;

public class UserServiceImpl implements IUserService {
	private IUserDao userDao = new UserDaoImpl();

	@Override
	public void registerUser(User user) throws UserExistException {
		// TODO 自动生成的方法存根
		if (userDao.find(user.getUserName()).getUserName() != null) {
			// 这里抛编译时异常的原因：是我想上一层程序处理这个异常，以给用户一个友好提示
			throw new UserExistException("注册的用户名已存在！！！");
		}
		userDao.add(user);
	}

	@Override
	public User loginUser(String userName, String userPwd) {
		// TODO 自动生成的方法存根
		return userDao.find(userName, userPwd);
	}

}
