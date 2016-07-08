package cn.ac.ict.web.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.lucene.search.highlight.InvalidTokenOffsetsException;

import lucene_zzy.lucene_driver;

/**
 * @author weilu
 * @creation 2015年9月29日
 * 
 */
@WebServlet("/servlet/luceneServlet")
public class luceneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public luceneServlet() {
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
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String OriPath = "/root/wl/article";
		String IndexPath = "/root/wl/index";
		String os = System.getProperty("os.name");
		if (os.toLowerCase().startsWith("win")) {
			OriPath = "D:/科普文章";
			IndexPath = "D:/索引路径";
		}
		// String question = request.getParameter("question");
		// 用於解決中文亂碼問題，解析英文也沒有問題
		String question = new String(request.getParameter("question").getBytes(
				"ISO-8859-1"), "UTF-8");
		System.out.println(question);
		// lucene_driver.createIndexesOnLocal(OriPath, IndexPath, null, "GBK");
		String[] fields = { "title", "path", "contents", "highlight" };
		// List<Map<String, String>> reslist = lucene_driver
		// .searchByIndexesOnLocal(question, fields, IndexPath);
		List<Map<String, String>> reslist = null;
		try {
			reslist = lucene_driver.searchToHighlighter(question, fields, null,
					null, IndexPath);
		} catch (InvalidTokenOffsetsException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}

		String ret_json = "[";
		String tmp = "";
		for (Map<String, String> map : reslist) {
			ret_json += "{";
			for (String key : map.keySet()) {
				if (key.equals("path")) {
					tmp = map.get(key);
					ret_json += "\""
							+ key
							+ "\":\""
							+ string2Json(tmp
									.substring(tmp.lastIndexOf("\\") + 1))
							+ "\",";
				} else
					ret_json += "\"" + key + "\":\""
							+ string2Json(map.get(key)) + "\",";
			}
			// pie_json= pie_json.trim().replaceAll(".$", "]");
			ret_json = ret_json.trim().replaceAll(".$", "},");
		}
		ret_json = ret_json.trim().replaceAll(".$", "]");

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
		doGet(request, response);
	}

	String string2Json(String s) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			switch (c) {
			case '\"':
				sb.append("\\\"");
				break;
			case '\\':
				sb.append("\\\\");
				break;
			case '/':
				sb.append("\\/");
				break;
			case '\b':
				sb.append("\\b");
				break;
			case '\f':
				sb.append("\\f");
				break;
			case '\n':
				sb.append("\\n");
				break;
			case '\r':
				sb.append("\\r");
				break;
			case '\t':
				sb.append("\\t");
				break;
			default:
				sb.append(c);
			}
		}
		return sb.toString();
	}
}
