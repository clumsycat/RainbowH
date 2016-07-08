package cn.ac.ict.web.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.ac.ict.dao.impl.MineImpala;

/**
 * @author weilu
 * @creation 2015年10月12日
 * 
 */
@WebServlet("/servlet/getCurrentEdition")
public class getcurrentedition extends HttpServlet {

	/**
	 * 使用exce，实现ping
	 */
	private static final long serialVersionUID = -3508822274629319862L;
	private static String database = "";
	static MineImpala minepala=new MineImpala();

	public getcurrentedition() {
		super();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @param args
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 设置请求和响应的字符集
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		String ret_json = "";
		if (!database.equals("upwebserver")) {
			minepala.chooseDatabase("upwebserver");
			database = "upwebserver";
		}
		List<String> result = minepala
				.Query("select * from updateinfo order by updatetime desc limit 1");
		System.out.println(result.get(1));
		String edition[] = result.get(1).split(",");
		// name,id,hdfs_path,updatetime

		ret_json = "{\"id\":\"" + edition[1] + "\",\"name\":\"" + edition[0]
				+ "\",\"updatetime\":\"" + edition[3] + "\"}";
		java.io.OutputStream ous = response.getOutputStream();
		ous.write(ret_json.getBytes("UTF-8"));

		ous.flush();
		ous.close();
	}
}
