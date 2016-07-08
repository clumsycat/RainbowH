package cn.ac.ict.web.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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

/**
 * Servlet implementation class UploadServlet
 * �����ϴ��ļ������ػ��������ڿ���ֱ�ӽ�urlдΪdaemonĿ�ĵ�ַ���ʴ˹���δ��ʹ�� ����daemon����ִ����ȷ�ϴ�pdf�ļ����ʣ����ô˹���
 */
@WebServlet("/servlet/UpLoadServlet")
public class UpLoadServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String filePath; // �ļ����Ŀ¼
	private String tempPath; // ��ʱ�ļ�Ŀ¼
	private String hdfs_path = "";
	private String file_old_name = "";
	private String file_new_name = "";

	// ��ʼ��
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		// �������ļ��л�ó�ʼ������
		// filePath = config.getInitParameter("filepath");
		// tempPath = config.getInitParameter("temppath");
		// ServletContext context = getServletContext();
		// filePath = context.getRealPath(filePath);
		// tempPath = context.getRealPath(tempPath);
		filePath = "/root/wl/file";
		tempPath = "/root/wl/filetmp";
		getServletContext().log("�ļ����Ŀ¼����ʱ�ļ�Ŀ¼׼����� ...");
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
			// threshold ���ޡ��ٽ�ֵ����Ӳ�̻��� 1M
			diskFactory.setSizeThreshold(4 * 1024 * 1024);
			// repository �����ң�����ʱ�ļ�Ŀ¼
			diskFactory.setRepository(new File(tempPath));

			ServletFileUpload upload = new ServletFileUpload(diskFactory);
			// ���������ϴ�������ļ���С 1024M
			upload.setSizeMax(1024 * 1024 * 1024);
			// ����HTTP������Ϣͷ
			List fileItems = upload.parseRequest(request);
			Iterator iter = fileItems.iterator();
			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();
				if (item.isFormField()) {
					getServletContext().log("������������ ...");
					processFormField(item, pw);
				} else {
					getServletContext().log("�����ϴ����ļ� ...");
					processUploadFile(item, pw);
				}
			}// end while()
			UploadToHDFS();

			pw.close();
		} catch (Exception e) {
			getServletContext()
					.log("ʹ�� fileupload ��ʱ�����쳣 ..." + e.getMessage());
			e.printStackTrace();
		}// end try ... catch ...
	}// end doPost()

	private void UploadToHDFS() throws IOException {
		// TODO �Զ����ɵķ������

		if (!hdfs_path.endsWith("/"))
			hdfs_path += "/";
		String cmd = "hdfs dfs -copyFromLocal -f " + filePath + "/"
				+ file_old_name + " " + hdfs_path + file_new_name;
		getServletContext().log(cmd);
		Process process = Runtime.getRuntime().exec(cmd);
		try {
			process.waitFor();
		} catch (InterruptedException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
			getServletContext().log(e.getMessage());
		}
		process.destroy();
		// ɾ��ԭ����
		String rmcmd = "rm -f " + filePath + "/" + file_old_name;
		getServletContext().log(rmcmd);
		process = Runtime.getRuntime().exec(rmcmd);
		try {
			process.waitFor();
		} catch (InterruptedException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
			getServletContext().log(e.getMessage());
		}
		process.destroy();

	}

	// ������������
	private void processFormField(FileItem item, PrintWriter pw)
			throws Exception {
		String name = item.getFieldName();
		String value = item.getString();
		// pw.println(name + " : " + value + "\r\n");
		if (name.equals("hdfs_path"))
			hdfs_path = value;
		else if (name.equals("file_name"))
			file_new_name = value;
	}

	// �����ϴ����ļ�
	private void processUploadFile(FileItem item, PrintWriter pw)
			throws Exception {
		// ��ʱ���ļ���������������·������ע��ӹ�һ��
		String filename = item.getName();
		getServletContext().log("�������ļ�����" + filename);
		int index = filename.lastIndexOf("\\");
		filename = filename.substring(index + 1, filename.length());
		file_old_name = filename;

		long fileSize = item.getSize();

		if ("".equals(filename) && fileSize == 0) {
			getServletContext().log("�ļ���Ϊ�� ...");
			return;
		}

		File uploadFile = new File(filePath + "/" + filename);
		item.write(uploadFile);
		// pw.println(filename + " �ļ�������� ...");
		// pw.println("�ļ���СΪ ��" + fileSize + "\r\n");
		pw.print("{\"success\":1 }");
	}

	// doGet
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doPost(request, response);
	}
}