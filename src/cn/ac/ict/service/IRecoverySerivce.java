/**
 * 
 */
package cn.ac.ict.service;

import java.util.List;

import cn.ac.ict.domain.HDFSFile;
import cn.ac.ict.domain.User;

/**
 * @author weilu
 * @creation 2015年9月30日
 * 
 */
public interface IRecoverySerivce {
	/**
	 * 彻底清空数据库
	 */
	void clearDelete();
	
	/**
	 * 恢复某个文件
	 * @param file
	 * @return 
	 */
	HDFSFile recovery(String file_id);
	
	/**
	 * 彻底删除某个文件
	 * @param file
	 */
	void delete(String file_id);
	
	/**
	 * 插入一个进行删除操作的文件
	 * @param file
	 */
	void insertDelete(HDFSFile file, User user);
	
	List<HDFSFile> showAllFiles();


}
