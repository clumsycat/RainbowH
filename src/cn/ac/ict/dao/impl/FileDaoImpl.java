package cn.ac.ict.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import cn.ac.ict.dao.IFileDao;
import cn.ac.ict.domain.HDFSFile;
import cn.ac.ict.domain.User;

/**
 * @author weilu
 * @creation 2015年10月10日
 * 
 */
public class FileDaoImpl implements IFileDao {
	
	@Override
	public void clearFiles() {
		// TODO 自动生成的方法存根
		Connection conn=MysqlConnection.getConnection();
		String sql = "truncate table deleteinfo";
		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			rs.close();
			st.close();
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		finally{
			MysqlConnection.closeConnection(conn);
		}
	}
	@Override
	public void delete(String file_id) {
		// TODO 自动生成的方法存根
		Connection conn=MysqlConnection.getConnection();
		String sql = "delete * from deleteinfo where IndexID=" +file_id;
		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			rs.close();
			st.close();
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		finally{
			MysqlConnection.closeConnection(conn);
		}
	}

	@Override
	public void add(HDFSFile file, User user) {
		/*	int file_size;//`FileSize`  
		int view_count;// `IndexHeat`  
		int download_count;// `IndexDownload`  
		String author_id;//`AuthorId`  
		String author_name;//`AuthorName`  
		String file_id; // `IndexID`    
		String parent_id; // `ParentID` 
		String file_title;// `IndexName`  
		String file_type;// `IndexType`  
		String index_level;//`IndexLevel` 
		String key_words;//`KeyWords`  
		String index_fullpath;//`IndexFullPath`  
		String index_abstract;//`IndexAbstract` 
		String delete_user;//`DeleteUser`  
		String operation_type;//`OperationType` 
		Timestamp update_time;//`UpdateTime`  
		Timestamp delete_time;//`DeleteTime`  
	*/	
		Connection conn=MysqlConnection.getConnection();
		String sql ="insert into deleteinfo(`IndexID`,`AuthorName`,`AuthorId` ,`FileSize` ,`IndexName`,`IndexType`,`KeyWords`,"
				+ "`IndexFullPath` ,`IndexHeat` ,`IndexDownload` ,`DeleteUser` ,`UpdateTime` ,`DeleteTime`, `ParentID` ,`IndexLevel`,"
				+ "`IndexAbstract`,`OperationType`) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, file.getFile_id());
			ps.setString(2, file.getAuthor_name());
			ps.setString(3, file.getAuthor_id());
			ps.setInt(4, file.getFile_size());
			ps.setString(5, file.getFile_title());
			ps.setInt(6, file.getFile_type());
			ps.setString(7, file.getKey_words());
			ps.setString(8, file.getIndex_fullpath());
			ps.setInt(9, file.getView_count());
			ps.setInt(10, file.getDownload_count());
			ps.setString(11, user.getUserName());
			ps.setTimestamp(12, file.getUpdate_time());
			Date data = new Date();
			ps.setTimestamp(13, new Timestamp(data.getTime()));
			ps.setString(14,file.getParent_id());
			ps.setInt(15,file.getIndex_level());
			ps.setString(16, file.getIndex_abstract());
			ps.setString(17,file.getOperation_type());
			int i=ps.executeUpdate();//i=1时，成功插入
			ps.close();
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}finally{
			MysqlConnection.closeConnection(conn);
		}
	}
	@Override
	public List<HDFSFile> findAll() {
		List<HDFSFile> filelists = new ArrayList();
		Connection conn=MysqlConnection.getConnection();
		String sql = "select * from deleteinfo";
		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			HDFSFile file=new HDFSFile();
			while (rs.next()) {
				file.setFile_id(rs.getString("IndexID"));
				file.setAuthor_id(rs.getString("AuthorId"));
				file.setAuthor_name(rs.getString("AuthorName"));
				file.setFile_size( rs.getInt("FileSize"));
				file.setFile_title(rs.getString("IndexName"));
				file.setFile_type(rs.getInt("IndexType"));
				file.setKey_words(rs.getString("KeyWords"));
				file.setIndex_fullpath(rs.getString("IndexFullPath"));
				file.setView_count( rs.getInt("IndexHeat"));
				file.setDownload_count( rs.getInt("IndexDownload"));
				file.setUpdate_time(rs.getTimestamp("UpdateTime"));
				file.setDelete_time(rs.getTimestamp("DeleteTime"));
				file.setDelete_user(rs.getString("DeleteUser"));
				file.setParent_id(rs.getString("ParentID"));
				file.setIndex_level(rs.getInt("IndexLevel"));
				file.setIndex_abstract(rs.getString("IndexAbstract"));
				file.setOperation_type(rs.getString("OperationType"));
				filelists.add(file);
			}
			rs.close();
			st.close();
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		finally{
			MysqlConnection.closeConnection(conn);
		}
		return filelists;
	}
	@Override
	public HDFSFile find(String file_id) {
		// TODO 自动生成的方法存根
		Connection conn=MysqlConnection.getConnection();
		String sql = "select * from deleteinfo where file_id=" + file_id;
		HDFSFile file=new HDFSFile();
		try {
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			while (rs.next()) {
				file.setFile_id(rs.getString("IndexID"));
				file.setAuthor_id(rs.getString("AuthorId"));
				file.setAuthor_name(rs.getString("AuthorName"));
				file.setFile_size( rs.getInt("FileSize"));
				file.setFile_title(rs.getString("IndexName"));
				file.setFile_type(rs.getInt("IndexType"));
				file.setKey_words(rs.getString("KeyWords"));
				file.setIndex_fullpath(rs.getString("IndexFullPath"));
				file.setView_count( rs.getInt("IndexHeat"));
				file.setDownload_count( rs.getInt("IndexDownload"));
				file.setUpdate_time(rs.getTimestamp("UpdateTime"));
				file.setDelete_time(rs.getTimestamp("DeleteTime"));
				file.setDelete_user(rs.getString("DeleteUser"));
				file.setParent_id(rs.getString("ParentID"));
				file.setIndex_level(rs.getInt("IndexLevel"));
				file.setIndex_abstract(rs.getString("IndexAbstract"));
				file.setOperation_type(rs.getString("OperationType"));
			}
			rs.close();
			st.close();
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		finally{
			MysqlConnection.closeConnection(conn);
		}
		return file;
	}

}
