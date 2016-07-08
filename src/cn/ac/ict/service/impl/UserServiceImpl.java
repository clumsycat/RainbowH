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
		// TODO �Զ����ɵķ������
		if (userDao.find(user.getUserName()).getUserName() != null) {
			// �����ױ���ʱ�쳣��ԭ����������һ�����������쳣���Ը��û�һ���Ѻ���ʾ
			throw new UserExistException("ע����û����Ѵ��ڣ�����");
		}
		userDao.add(user);
	}

	@Override
	public User loginUser(String userName, String userPwd) {
		// TODO �Զ����ɵķ������
		return userDao.find(userName, userPwd);
	}

}
