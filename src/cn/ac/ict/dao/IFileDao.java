package cn.ac.ict.dao;

import java.util.List;

import cn.ac.ict.domain.HDFSFile;
import cn.ac.ict.domain.User;

/**
 * @author weilu
 * @creation 2015��9��30��
 * 
 */
public interface IFileDao {
	/**
	 * ������ݿ�
	 */
	void clearFiles();
	
	/**
	 * ����ɾ��ĳ���ļ�
	 * @param file
	 */
	void delete(String file_id);
	
	/**
	 * ���ɾ���ļ������ݿ�
	 * @param file
	 */
	void add(HDFSFile file,User user);

	/**
	 * �г������ļ�
	 * @return
	 */
	List<HDFSFile> findAll();

	/**
	 * �г�ĳ�ļ�id���ļ�
	 * @return
	 */
	HDFSFile find(String file_id);
}
