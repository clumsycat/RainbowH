package cn.ac.ict.web.controller;

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
@WebServlet("/servlet/HdfsServlet")
public class HdfsServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3508822274629319862L;

	public HdfsServlet() {
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
		// �����������Ӧ���ַ���
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		// ��ȡ�û�����������
		// getΪ��ȡ�����ļ�
		String user_action = request.getParameter("action").trim();
		response.setHeader("Cache-Control", "no-cache");
		//String urlstr="http://openapi.baidu.com/widget/social/"+user_action;
		String urlstr="http://10.10.108.72:50070"+user_action;
		BufferedReader in = null;
		String ret_json = "";
		//URL url = new URL("http://10.10.108.72:50070/");
		try{
		URL url = new URL(urlstr);
		URLConnection connection = url.openConnection();
        // ����ͨ�õ���������
        connection.setRequestProperty("accept", "*/*");
        connection.setRequestProperty("connection", "Keep-Alive");
        connection.setRequestProperty("user-agent",
                "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
        // ����ʵ�ʵ�����
        connection.connect();

        in = new BufferedReader(new InputStreamReader(
                connection.getInputStream()));
        String line;
        while ((line = in.readLine()) != null) {
        	ret_json += line;
        }
        
		java.io.OutputStream ous = response.getOutputStream();
		ous.write(ret_json.getBytes("UTF-8"));

		ous.flush();
		ous.close();
		}
		finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
	}
}
