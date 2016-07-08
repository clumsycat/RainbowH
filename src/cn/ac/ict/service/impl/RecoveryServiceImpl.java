package cn.ac.ict.service.impl;

import java.io.IOException;
import java.util.List;

import cn.ac.ict.dao.IFileDao;
import cn.ac.ict.dao.impl.FileDaoImpl;
import cn.ac.ict.domain.HDFSFile;
import cn.ac.ict.domain.User;
import cn.ac.ict.service.IRecoverySerivce;

public class RecoveryServiceImpl implements IRecoverySerivce {
	IFileDao FileDao = new FileDaoImpl();
	private static String deletefilepath = "/root/wl/deletefile/";

	@Override
	public void clearDelete() {
		FileDao.clearFiles();
	}

	@Override
	public HDFSFile recovery(String file_id) {
		// TODO 需要把恢复到HDFS的相关完善
		HDFSFile file = FileDao.find(file_id);
		String cmd = "hdfs dfs -put " + deletefilepath + file.getFile_title()
				+ " " + file.getIndex_fullpath() + file.getFile_title();
		try {
			Process process = Runtime.getRuntime().exec(cmd);
			process.waitFor();
		} catch (IOException | InterruptedException e) {
			e.printStackTrace();
		}
		FileDao.delete(file_id);
		return file;
	}

	@Override
	public void insertDelete(HDFSFile file, User user) {
		// 将文件下载至本地的功能在DeleteServlet中实现
		FileDao.add(file, user);
	}

	@Override
	public void delete(String file_id) {
		// TODO:本地文件的删除
		HDFSFile file = FileDao.find(file_id);
		String cmd = "rm -f " + deletefilepath + file.getFile_title();
		try {
			Process process = Runtime.getRuntime().exec(cmd);
			process.waitFor();
		} catch (IOException | InterruptedException e) {
			e.printStackTrace();
		}
		FileDao.delete(file_id);
	}

	@Override
	public List<HDFSFile> showAllFiles() {
		return FileDao.findAll();
	}
}