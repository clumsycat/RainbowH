/**
 * 
 */
package cn.ac.ict.servlet;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author Administrator
 *
 */
public class DaemonProServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -4538168547531808441L;
	public static final String IP_ADDR = "10.10.108.85";// 服务器地址
	public static final int PORT = 8888;// 服务器端口号

	public DaemonProServlet() {
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
		String ret_json = "123456";

		// 获取用户操作的类型
		// get为获取配置文件
		String user_action = request.getParameter("action").trim();
		String jsonreq=request.getParameter("jsons").trim();
		System.out.println("jsonreq:" + jsonreq);
		if(user_action.equals("GetProperties"))
		{
			ret_json=query(jsonreq);
			//ret_json="	{\"Key\":\"UpdateProperties\", \"Daemon\": {\"CACHE_NEXT_PAGES\":\"true\",\"ITEM_LIMIT\":30,\"PAGE_LIMIT\":3,\"THREAD_TIMEOUT\":60,\"USE_SQL_COMBINE\":\"true\",\"SQL_COMBINE_PERIOD\":5,\"SQL_COMBINE_MAXITEMS\":20,\"USE_MEMCACHE\":\"true\",\"SELECT_TARGET_DATABASE\":\"impala\",\"IMPALA_INITIAL_POOL_SIZE\":10,\"IMPALA_MAX_POOL_SIZE\":20,\"IMPALA_MIN_POOL_SIZE\":10,\"BASE_HDFS_PATH\":\"hdfs:/hadoop-72:9000\"},\"Memcache\":{\"60-m\":24576,\"60-t\":12,\"61-m\":24576,\"61-t\":12,\"62-m\":24576,\"62-t\":12,\"74-m\":32768,\"74-t\":24,\"85-m\":491520,\"85-t\":24,\"86-m\":491520,\"86-t\":24}}";
		}
		else if(user_action.equals("UpdateProperties"))
		{
			ret_json=query(jsonreq);
		}
		// 返回给前端的字符
		response.setHeader("Cache-Control", "no-cache");
		java.io.OutputStream ous = response.getOutputStream();
		ous.write(ret_json.getBytes("UTF-8"));

		ous.flush();
		ous.close();
	}

	String query(String jsonreq) {
		DataInputStream netInputStream;
		DataOutputStream netOutputStream;
		Socket sc;
		String message="";
		byte[] buffer = jsonreq.getBytes();
		byte[] readLen=new byte[2048];
		try {
			sc = new Socket(IP_ADDR, PORT);
			netInputStream = new DataInputStream(sc.getInputStream());
			netOutputStream = new DataOutputStream(sc.getOutputStream());
			//发送请求
			netOutputStream.write(buffer);
			netOutputStream.flush();
			//接受
			netInputStream.read(readLen);

			netInputStream.close();
			netOutputStream.close();
			sc.close();
			message = new String(readLen,"GBK").trim();
			System.out.println("\""+message+"\"");
			System.out.println(message.length());
			return message;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return message;
	}

}
