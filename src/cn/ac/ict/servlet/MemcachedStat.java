package cn.ac.ict.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MemcachedStat
 */
@WebServlet("/view/MemcachedStat")
public class MemcachedStat extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	private static String[] serverList = { "10.10.108.60", "10.10.108.61",
			"10.10.108.62", "10.10.108.74", "10.10.108.85", "10.10.108.86" };

	public MemcachedStat() {
		super();

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// System.out.println("hello");
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		ServletOutputStream ops = response.getOutputStream();
		StringBuffer sb = new StringBuffer();
		sb.append("[");  
		for (int i = 0; i < serverList.length; ++i) {
			String shPath_jsonRes = "/root/wanghao/getJsonRes.sh ";
			String cmd_jsonRes[] = { "/bin/sh", "-c",
					shPath_jsonRes + serverList[i] };
			Process process = Runtime.getRuntime().exec(cmd_jsonRes);
			try {
				process.waitFor();

				BufferedReader br_json = new BufferedReader(
						new InputStreamReader(process.getInputStream()));

				String line_json;
				while ((line_json = br_json.readLine()) != null) {
					sb.append(line_json);
				}

			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			if(i==serverList.length-1)
				continue;
			sb.append(",");
		}
		sb.append("]");
		request.setAttribute("mem-json",sb);
		request.getRequestDispatcher("/view/MonitorServlet").forward(request,response);
		ops.write(sb.toString().getBytes());
		ops.flush();
		ops.close();
	}
}
