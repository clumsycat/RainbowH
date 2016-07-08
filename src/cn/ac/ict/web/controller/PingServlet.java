package cn.ac.ict.web.controller;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

/**
 * @author Administrator
 *
 */
@WebServlet("/servlet/PingServlet")
public class PingServlet extends HttpServlet {

	/**
	 * 使用exce，实现ping
	 */
	private static final long serialVersionUID = -3508822274629319862L;

	public PingServlet() {
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
		// 获取用户操作的类型
		// get为获取配置文件
		String IP = request.getParameter("IP").trim();
		

		String ret_json="";
		
		String rettime=getAvgTime(IP);
		if(rettime.equals(""))
			ret_json="{\"status\":\"fail\"}";
		else
			ret_json="{\"status\":\"success\",\"time\":\""+ rettime+"\"}";
		java.io.OutputStream ous = response.getOutputStream();
		ous.write(ret_json.getBytes("UTF-8"));

		ous.flush();
		ous.close();
	}
	static String getAvgTime(String ip){
		String line = "";//null;
		String line1= "";
		try {
			Process pro = Runtime.getRuntime().exec("ping "+ip+" -c 3");
			BufferedReader buf = new BufferedReader(new InputStreamReader(
					pro.getInputStream()));
			while ((line = buf.readLine()) != null)
			{
				//line ="0.213/0.226/0.251/0.012 msYou have mail ";
				//System.out.println(line);
				Pattern p=Pattern.compile("[0-9]\\.[0-9]{3}\\/[0-9]\\.[0-9]{3}\\/");  
				Matcher m=p.matcher(line);  
				while(m.find()){  
					line=m.group().substring(6, 11);
					//System.out.println(line=m.group().substring(6, 11)+"xunhuan"); 
				}
				line1=line;
			}
			buf.close();
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
		return line1;
	}
}
