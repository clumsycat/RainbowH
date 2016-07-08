/**
 * 
 */
package cn.ac.ict.service;

import java.util.List;

import cn.ac.ict.domain.HDFSFile;
import cn.ac.ict.domain.User;

/**
 * @author weilu
 * @creation 2015��9��30��
 * 
 */
public interface IRecoverySerivce {
	/**
	 * ����������ݿ�
	 */
	void clearDelete();
	
	/**
	 * �ָ�ĳ���ļ�
	 * @param file
	 * @return 
	 */
	HDFSFile recovery(String file_id);
	
	/**
	 * ����ɾ��ĳ���ļ�
	 * @param file
	 */
	void delete(String file_id);
	
	/**
	 * ����һ������ɾ���������ļ�
	 * @param file
	 */
	void insertDelete(HDFSFile file, User user);
	
	List<HDFSFile> showAllFiles();


}
