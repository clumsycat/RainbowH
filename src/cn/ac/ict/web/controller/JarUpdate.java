package cn.ac.ict.web.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import cn.ac.ict.dao.impl.MineImpala;

/**
 * 用于版本更新，上传到hdfs上后将信息存至Impala
 * @author weilu
 * @creation 2015年10月10日
 * 
 */
@WebServlet("/servlet/JarUpdate")
public class JarUpdate extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String filePath; // 文件存放目录
	private String tempPath; // 临时文件目录
	private String hdfs_path = "/user/updateIndex/";
	private String jar_id="";
	private String file_old_name="";
	private String file_new_name="";

	// 初始化
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		// 从配置文件中获得初始化参数
		// filePath = config.getInitParameter("filepath");
		// tempPath = config.getInitParameter("temppath");
		// ServletContext context = getServletContext();
		// filePath = context.getRealPath(filePath);
		// tempPath = context.getRealPath(tempPath);
		filePath = "/root/wl/file";
		tempPath = "/root/wl/filetmp";
		getServletContext().log("文件存放目录、临时文件目录准备完毕 ...");
		getServletContext().log(filePath);
		getServletContext().log(tempPath);
	}

	// doPost
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		try {
			DiskFileItemFactory diskFactory = new DiskFileItemFactory();
			// threshold 极限、临界值，即硬盘缓存 1M
			diskFactory.setSizeThreshold(4 *1024 * 1024);
			// repository 贮藏室，即临时文件目录
			diskFactory.setRepository(new File(tempPath));

			ServletFileUpload upload = new ServletFileUpload(diskFactory);
			// 设置允许上传的最大文件大小 1024M
			upload.setSizeMax(1024 * 1024 * 1024);
			// 解析HTTP请求消息头
			List fileItems = upload.parseRequest(request);
			Iterator iter = fileItems.iterator();
			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();
				if (item.isFormField()) {
					getServletContext().log("处理表单内容 ...");
					processFormField(item, pw);
				} else {
					getServletContext().log("处理上传的文件 ...");
					processUploadFile(item, pw);
				}
			}// end while()
			UploadToHDFS();
			InsertToImpala();
			
			pw.close();
		} catch (Exception e) {
			getServletContext().log("使用 fileupload 包时发生异常 ..."+e.getMessage());
			e.printStackTrace();
		}// end try ... catch ...
	}// end doPost()

	private void InsertToImpala() {
		// TODO 自动生成的方法存根
		MineImpala.chooseDatabase("upwebserver");
		String query="insert into updateinfo values('"+file_new_name+"','"+jar_id+"','/user/updateIndex',now())";
		try {
			MineImpala.Update(query);
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}
	
	private void UploadToHDFS() throws IOException {
		// TODO 自动生成的方法存根
		
		if(!hdfs_path.endsWith("/"))
			hdfs_path+="/";
		String cmd = "hdfs dfs -copyFromLocal -f " + filePath+"/" +file_old_name +" /user/updateIndex/"
				+file_new_name;
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
		//删除原来的
		String rmcmd = "rm -f " + filePath+"/" +file_old_name;
		getServletContext().log(rmcmd);
		process = Runtime.getRuntime().exec(rmcmd);
		try {
			process.waitFor();
		} catch (InterruptedException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			getServletContext().log(e.getMessage());
		}
		process.destroy();

	}

	// 处理表单内容
	private void processFormField(FileItem item, PrintWriter pw)
			throws Exception {
		String name = item.getFieldName();
		String value = item.getString();
		//pw.println(name + " : " + value + "\r\n");
		if(name.equals("jar_name"))
			file_new_name=value;
		else if(name.equals("jar_id"))
			jar_id=value;
	}

	// 处理上传的文件
	private void processUploadFile(FileItem item, PrintWriter pw)
			throws Exception {
		// 此时的文件名包含了完整的路径，得注意加工一下
		String filename = item.getName();
		file_old_name=filename;
		getServletContext().log("完整的文件名：" + filename);
		int index = filename.lastIndexOf("\\");
		filename = filename.substring(index + 1, filename.length());

		long fileSize = item.getSize();

		if ("".equals(filename) && fileSize == 0) {
			getServletContext().log("文件名为空 ...");
			return;
		}

		File uploadFile = new File(filePath + "/" + filename);
		item.write(uploadFile);
		//pw.println(filename + " 文件保存完毕 ...");
		//pw.println("文件大小为 ：" + fileSize + "\r\n");
		pw.print("{\"success\":1 }");
	}

	// doGet
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doPost(request, response);
	}
}
