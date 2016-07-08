package cn.ac.ict.web.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.ac.ict.domain.HDFSFile;
import cn.ac.ict.service.IRecoverySerivce;
import cn.ac.ict.service.impl.RecoveryServiceImpl;

/**
 * Servlet implementation class RecoveryServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/servlet/RecoveryServlet" })
public class RecoveryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	/**
	 * 恢复删除的文件的servlet
	 * 
	 * @see HttpServlet#HttpServlet()
	 */
	public RecoveryServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 获取用户填写的登录用户名
		request.setCharacterEncoding("UTF-8");
		String key = request.getParameter("action");
		IRecoverySerivce service = new RecoveryServiceImpl();
		StringBuilder ret_json = new StringBuilder();
		String file_id="";
		switch (key) {
		case "show": {
			List <HDFSFile> filelist=	service.showAllFiles();
			//使用StingBuilder，因为效率最高
			ret_json.append("[");
			for(HDFSFile file : filelist)
			{
				ret_json.append("{\"file_id\":\""+file.getFile_id()+"\",");
				ret_json.append("\"author_name\":\""+file.getAuthor_name()+"\",");
				ret_json.append("\"author_id\":\""+file.getAuthor_id()+"\",");
				ret_json.append("\"file_size\":\""+file.getFile_size()+"\",");
				ret_json.append("\"file_title\":\""+file.getFile_title()+"\",");
				ret_json.append("\"file_type\":\""+file.getFile_type()+"\",");
				ret_json.append("\"key_words\":\""+file.getKey_words()+"\",");
				ret_json.append("\"index_fullpath\":\""+file.getIndex_fullpath()+"\",");
				ret_json.append("\"view_count\":\""+file.getView_count()+"\",");
				ret_json.append("\"download_count\":\""+file.getDownload_count()+"\",");
				ret_json.append("\"delete_user\":\""+file.getDelete_user()+"\",");
				ret_json.append("\"update_time\":\""+file.getUpdate_time()+"\",");
				ret_json.append("\"delete_time\":\""+file.getDelete_time()+"\"},");		
			}
			ret_json = ret_json.deleteCharAt(ret_json.length()-1);
			ret_json.append("]");
		}
			break;
		case "delete":
			file_id=request.getParameter("file_id");
			service.delete(file_id);
			break;
		case "recovery":
			file_id=request.getParameter("file_id");
			HDFSFile file = service.recovery(file_id);
			ret_json.append("{\"file_id\":\""+file.getFile_id()+"\",");
			ret_json.append("\"author_name\":\""+file.getAuthor_name()+"\",");
			ret_json.append("\"author_id\":\""+file.getAuthor_id()+"\",");
			ret_json.append("\"file_size\":\""+file.getFile_size()+"\",");
			ret_json.append("\"file_title\":\""+file.getFile_title()+"\",");
			ret_json.append("\"file_type\":\""+file.getFile_type()+"\",");
			ret_json.append("\"key_words\":\""+file.getKey_words()+"\",");
			ret_json.append("\"index_fullpath\":\""+file.getIndex_fullpath()+"\",");
			ret_json.append("\"view_count\":\""+file.getView_count()+"\",");
			ret_json.append("\"download_count\":\""+file.getDownload_count()+"\",");
			ret_json.append("\"delete_user\":\""+file.getDelete_user()+"\",");
			ret_json.append("\"update_time\":\""+file.getUpdate_time()+"\",");
			ret_json.append("\"delete_time\":\""+file.getDelete_time()+"\"}");		
			break;
		case "clear":
			break;
		}
		System.out.println(ret_json);
		response.setHeader("Cache-Control", "no-cache");
		java.io.OutputStream ous = response.getOutputStream();
		ous.write(ret_json.toString().getBytes("UTF-8"));
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
	}

}
