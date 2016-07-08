package cn.ac.ict.web.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ClusterServlet
 */
@WebServlet("/servlet/ClusterServlet")
public class ClusterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ClusterServlet() {
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
		// �����������Ӧ���ַ���
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		String ret_json = "{";
		String pie_json="\"pie\":[";
		String chart_json="\"chart\":[";
		String table_json="\"table\":[";
		/*
		 * ����TXT�ļ� String pathname = "D:\\clusters.txt"; //
		 * ����·�������·�������ԣ������Ǿ���·����д���ļ�ʱ��ʾ���·�� File filename = new File(pathname);
		 * // Ҫ��ȡ����·����input��txt�ļ� InputStreamReader reader = new
		 * InputStreamReader( new FileInputStream(filename)); // ����һ������������reader
		 * BufferedReader br = new BufferedReader(reader); //
		 * ����һ�����������ļ�����ת�ɼ�����ܶ���������
		 */
		try {
			// ��HDFS��ȡpie����
			String cmd = "hdfs dfs -cat /data/clusters.txt";
			Process process = Runtime.getRuntime().exec(cmd);
			try {
				process.waitFor();
				BufferedReader br_json = new BufferedReader(
						new InputStreamReader(process.getInputStream()));

				String line;
				while ((line = br_json.readLine()) != null) {
					if (line.contains("WARN"))
						continue;
					if(line.contains("####"))
						break;
					String[] strarray = line.split(",", 2);
					pie_json += "{\"name\":\"" +strarray[0]+ "\",\"value\":\""+ strarray[1]+ "\"},";
				}
				while ((line = br_json.readLine()) != null) {
					if (line.contains("WARN"))
						continue;
					if(line.contains("####"))
						break;
					String[] strarray = line.split(",", 2);
					chart_json += "{\"name\":\"" +strarray[0]+ "\",\"value\":\""+ strarray[1]+ "\"},";
				}
				while ((line = br_json.readLine()) != null) {
					if (line.contains("WARN"))
						continue;
					if(line.contains("####"))
						break;
					String[] strarray = line.split(",");
					table_json += "{\"name\":\"" +strarray[0]+ "\",\"value\":[\""+ strarray[1]+ "\",\"" + strarray[2]+"\",\"" + strarray[3]+"\",\"" + strarray[4]+"\",\"" + strarray[5]+"\"]},";
				}
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			char[] tmp_pie=pie_json.toCharArray();
			tmp_pie[pie_json.length()-1]=']';
			pie_json=new String(tmp_pie);
			char[] tmp_chart=chart_json.toCharArray();
			tmp_chart[chart_json.length()-1]=']';
			chart_json=new String(tmp_chart);
			char[] tmp_table=table_json.toCharArray();
			tmp_table[table_json.length()-1]=']';
			table_json=new String(tmp_table);
//			pie_json= pie_json.trim().replaceAll(".$", "]");
//			chart_json= chart_json.trim().replaceAll(".$", "]");
//			table_json= table_json.trim().replaceAll(".$", "]");
			/*if (pie_json.endsWith(",")) {
				pie_json = pie_json.substring(0, pie_json.length() - 1);
			}
			pie_json += "]";
			if (chart_json.endsWith(",")) {
				chart_json = chart_json.substring(0, chart_json.length() - 1);
			}
			chart_json += "]";
			if (table_json.endsWith(",")) {
				table_json = table_json.substring(0, table_json.length() - 1);
			}
			table_json += "]";*/
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ret_json+=pie_json+"," + chart_json +","+table_json+"}";
		java.io.OutputStream ous = response.getOutputStream();
		ous.write(ret_json.getBytes("UTF-8"));

		ous.flush();
		ous.close();
	}

}
