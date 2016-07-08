package cn.ac.ict.web.controller;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.ac.ict.dao.IFileDao;
import cn.ac.ict.domain.HDFSFile;
import cn.ac.ict.domain.User;
import cn.ac.ict.service.IRecoverySerivce;
import cn.ac.ict.service.impl.RecoveryServiceImpl;

/**
 * 用于将删除的文件恢复
 * Servlet implementation class DeleteServlet
 */
@WebServlet("/sevlet/DeleteServlet")
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String filePath = null;

	// 初始化
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		filePath = "/root/wl/deletefile/";
		getServletContext().log(filePath);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String ret_json = "{\"return\":\"OK\"}";

		HDFSFile file = new HDFSFile();
		file.setFile_id(request.getParameter("indexid"));
		file.setAuthor_id(request.getParameter("authorid"));
		file.setAuthor_name(request.getParameter("authorname"));
		file.setFile_size(Integer.parseInt( request.getParameter("filesize")));
		file.setFile_title(request.getParameter("indexname"));
		file.setFile_type(Integer.parseInt(request.getParameter("indextype")));
		file.setKey_words(request.getParameter("keywords"));
		file.setIndex_fullpath(request.getParameter("indexfullpath"));
		file.setView_count( Integer.parseInt(request.getParameter("indexheat")));
		file.setDownload_count( Integer.parseInt(request.getParameter("indexdownload")));
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		ts = Timestamp.valueOf(request.getParameter("updatetime"));
		file.setUpdate_time(ts);
		file.setParent_id(request.getParameter("parentid"));
		file.setIndex_level( Integer.parseInt(request.getParameter("indexlevel")));
		file.setIndex_abstract(request.getParameter("indexabstract"));
		file.setOperation_type(request.getParameter("operationtype"));
		
		// 向数据库中插入数据
		User user = (User) request.getSession().getAttribute("user");
		IRecoverySerivce service = new RecoveryServiceImpl();
		service.insertDelete(file, user);
		// 从HDFS下载文件
		String cmd = "hdfs dfs -get " + file.getIndex_fullpath() + "/" + file.getFile_title() + " "
				+ filePath;
		getServletContext().log(cmd);
		Process process = Runtime.getRuntime().exec(cmd);
		try {
			process.waitFor();
		} catch (InterruptedException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			getServletContext().log(e.getMessage());
		}
		process.destroy();

		response.setHeader("Cache-Control", "no-cache");
		java.io.OutputStream ous = response.getOutputStream();
		ous.write(ret_json.getBytes("UTF-8"));
		ous.flush();
		ous.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
