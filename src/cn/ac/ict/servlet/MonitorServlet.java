package cn.ac.ict.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import javax.servlet.ServletException;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MonitorServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4716372741052887446L;

	public MonitorServlet() {
		super();
		
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// MonitorMap.MoMap.put(key, value);
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String ret_json = "{\"return\":\"OK\"}";

		BufferedReader br = new BufferedReader(new InputStreamReader(
				(ServletInputStream) request.getInputStream()));
		String line = null;
		StringBuilder sb = new StringBuilder();
		while ((line = br.readLine()) != null) {
			sb.append(line);
		}
		String IP = request.getRemoteAddr();
		MonitorBean bean = new MonitorBean();
		bean.setAppName("Daemon");
		bean.setJson(sb.toString());
		bean.setIP(IP);
		Date date=new Date(); 
		
		bean.setUpdate_time(date);
		MonitorMap.MoMap.put(IP + "D", bean);
		// ����ֱ���ʾ������HashMap

		// ���ظ�ǰ�˵��ַ�
		response.setHeader("Cache-Control", "no-cache");
		java.io.OutputStream ous = response.getOutputStream();
		ous.write(ret_json.getBytes("UTF-8"));

		ous.flush();
		ous.close();
	}

}
