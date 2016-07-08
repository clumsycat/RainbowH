package cn.ac.ict.web.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GangliaXmlServlet
 */
@WebServlet("/servlet/GangliaXmlServlet")
public class GangliaXmlServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GangliaXmlServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		OutputStream ops=response.getOutputStream();
		
		StringBuffer sb=new StringBuffer();
		
		String shPath="/root/wanghao/getGangliaXml.sh";
		String cmd[] = { "/bin/sh", "-c",shPath};
		Process process=Runtime.getRuntime().exec(cmd);
		BufferedReader br=new BufferedReader(new InputStreamReader(process.getInputStream()));
		String line;
		try {
			process.waitFor();
			while((line=br.readLine())!=null){
				sb.append(line);
			}
		} catch (InterruptedException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}

		ops.write(sb.toString().getBytes());
		ops.flush();
		ops.close();
	}

}
