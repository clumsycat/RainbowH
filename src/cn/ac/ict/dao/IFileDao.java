package cn.ac.ict.dao;

import java.util.List;

import cn.ac.ict.domain.HDFSFile;
import cn.ac.ict.domain.User;

/**
 * @author weilu
 * @creation 2015年9月30日
 * 
 */
public interface IFileDao {
	/**
	 * 清空数据库
	 */
	void clearFiles();
	
	/**
	 * 彻底删除某个文件
	 * @param file
	 */
	void delete(String file_id);
	
	/**
	 * 添加删除文件至数据库
	 * @param file
	 */
	void add(HDFSFile file,User user);

	/**
	 * 列出所有文件
	 * @return
	 */
	List<HDFSFile> findAll();

	/**
	 * 列出某文件id的文件
	 * @return
	 */
	HDFSFile find(String file_id);
}
