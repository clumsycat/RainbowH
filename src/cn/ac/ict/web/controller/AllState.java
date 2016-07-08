package cn.ac.ict.web.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Map.Entry;
import java.util.TimeZone;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.ac.ict.domain.MonitorBean;
import cn.ac.ict.domain.MonitorMap;
@WebServlet("/servlet/AllState")
public class AllState extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8378236706547872859L;

	public AllState() {
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
		String ret_json = "";
		String key;
		MonitorBean bean;
		String D_json = "\"Daemon\":[";
		String M_json = "\"Memcache\":[";
		String G_json = "\"Ganglia\":";
	
		// 处理

		// 遍历HashMap
		Iterator<Entry<String, MonitorBean>> iterator = MonitorMap.MoMap
				.entrySet().iterator();
		while (iterator.hasNext()) {
			Entry<String, MonitorBean> entry = iterator.next();
			key = entry.getKey();
			bean = entry.getValue();
			if (key.endsWith("D")) {
				Date d1 = new Date();
				long diff = (d1.getTime() - bean.getUpdate_time().getTime()) / 1000;
				if (diff < 20)
					D_json += bean.getJson();
				else {
					SimpleDateFormat df = new SimpleDateFormat(
							"yyyy-MM-dd HH:mm:ss");
					df.setTimeZone(TimeZone.getTimeZone("GMT+8"));
					D_json += "{\"dead\":\"1\",\"IP\":\"" + bean.getIP()
							+ "\",\"time\":\""
							+ df.format(bean.getUpdate_time()) + "\"}";
				}
				D_json += ",";
			} else if (key.endsWith("M")) {
				M_json += bean.getJson();
				M_json += ",";
			} else if (key.endsWith("G"))
			{
				G_json += bean.getJson();
			}
		}
		if (D_json.endsWith(","))
			D_json = D_json.substring(0, D_json.length() - 1);
		D_json += "]";
		if (M_json.endsWith(","))
			M_json = M_json.substring(0, M_json.length() - 1);
		M_json += "]";
		if(G_json.equals("\"Ganglia\":"))
			G_json += "[]";
		else
			G_json +="";
		ret_json = "{" + D_json + "," + M_json + "," + G_json + "}";
		// 返回给前端的字符
		response.setHeader("Cache-Control", "no-cache");
		java.io.OutputStream ous = response.getOutputStream();
		ous.write(ret_json.getBytes("UTF-8"));

		ous.flush();
		ous.close();
	}
}
