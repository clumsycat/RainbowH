package cn.ac.ict.web.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GenerateServlet
 */
@WebServlet("/servlet/GenerateServlet")
public class GenerateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GenerateServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// 设置请求和响应的字符集
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		String ret_json = "{\"status\":\"success\"}";

		long data_size = Long.parseLong(request.getParameter("data_size"));
		String data_type = request.getParameter("data_unit");
		switch (data_type) {
		case "TB":
			long tb = 1099511627776L;
			data_size = data_size * tb;
			break;
		case "GB":
			long gb = 1073741824L;
			data_size = data_size * gb;
			break;
		}
		String hdfs_path = request.getParameter("hdfs_path");
		String csv_path = request.getParameter("csv_path");
		String machines[] = request.getParameterValues("machines");

		System.out.println(data_size);
		for (int i = 0; i < machines.length; i++) {
			String [] cmd={"/bin/sh","-c","/root/wl/bench.sh " + machines[i]+" "+ data_size
					+ " " + hdfs_path + " " + csv_path};
			Process process = Runtime.getRuntime().exec(cmd);
		}

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
