package cn.ac.ict.web.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ClusterServlet
 */
@WebServlet("/servlet/PM25Servlet")
public class PM25Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PM25Servlet() {
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
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// 设置请求和响应的字符集
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		String ret_json = "";
		String type = request.getParameter("type");
		StringBuilder pm=new StringBuilder("[");
		StringBuilder disease=new StringBuilder("[");
		/*
		 * 读入TXT文件 String pathname = "D:\\clusters.txt"; //
		 * 绝对路径或相对路径都可以，这里是绝对路径，写入文件时演示相对路径 File filename = new File(pathname);
		 * // 要读取以上路径的input。txt文件 InputStreamReader reader = new
		 * InputStreamReader( new FileInputStream(filename)); // 建立一个输入流对象reader
		 * BufferedReader br = new BufferedReader(reader); //
		 * 建立一个对象，它把文件内容转成计算机能读懂的语言
		 */
		try {
			// 从HDFS读取pie数据
			String cmd = "hdfs dfs -cat /data/pm2.5.csv";
			Process process = Runtime.getRuntime().exec(cmd);
			try {
				process.waitFor();
				BufferedReader br_json = new BufferedReader(
						new InputStreamReader(process.getInputStream()));

				String line;
				while ((line = br_json.readLine()) != null) {
					if (line.contains("WARN"))
						continue;
					String[] strarray = line.split(",");
					pm.append("["+ dateToUTC(strarray[0])+","+ strarray[1]+"],");
					disease.append("["+ dateToUTC(strarray[0])+","+ strarray[3]+"],");
				}
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		pm.replace(pm.length()-1, pm.length(), "]");
		disease.replace(disease.length()-1, disease.length(), "]");
		
		switch(type){
		case"pm":
			ret_json= pm.toString();
			break;
		case"disease":
			ret_json=disease.toString();
			break;
		}
		java.io.OutputStream ous = response.getOutputStream();
		ous.write(ret_json.getBytes("UTF-8"));

		ous.flush();
		ous.close();
	}

	private String dateToUTC(String original) {
		// TODO 自动生成的方法存根
		Date date = null;

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

		try {
			date = df.parse(original);
		} catch (ParseException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}

		Calendar cal =
		Calendar.getInstance(TimeZone.getDefault());//TimeZone.getDefault()获取主机的默认TimeZone，即时区偏移量。

		cal.setTime(date);

		return Long.toString(date.getTime()+cal.getTimeZone().getRawOffset());//cal.getTimeZone().getRawOffset()是相对utc的偏移量
	}

}
