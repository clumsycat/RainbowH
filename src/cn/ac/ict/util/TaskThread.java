/**
 * 
 */
package cn.ac.ict.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.channels.FileChannel;
import java.util.Date;
import java.util.Iterator;
import java.util.TimerTask;
import java.util.Map.Entry;

import javax.servlet.ServletContext;
import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

import cn.ac.ict.servlet.MonitorBean;
import cn.ac.ict.servlet.MonitorMap;

//��ʱ��ȡMemcached��Ϣ�Լ�Ganglia
public class TaskThread extends TimerTask {
	public static TaskThread taskThread = null;
	@SuppressWarnings("unused")
	private ServletContext context = null;
	private static boolean isRunning = false;
	private static String[] serverList = { "10.10.108.60", "10.10.108.61",
			"10.10.108.62", "10.10.108.74", "10.10.108.85", "10.10.108.86" };
	static String daemon_localpath = "/root/wl/monitor/daemon.txt";
	static String memcache_localpath = "/root/wl/monitor/memcache.txt";
	static String ganglia_localpath = "/root/wl/monitor/ganglia.txt";
	static String daemon_copypath = "/root/wl/monitor/copy/daemon.txt";
	static String memcache_copypath = "/root/wl/monitor/copy/memcache.txt";
	static String ganglia_copypath = "/root/wl/monitor/copy/ganglia.txt";
	static String daemon_hdfs_path = "/monitor/daemon.txt";
	static String memcache_hdfs_path = "/monitor/memcache.txt";
	static String ganglia_hdfs_path = "/monitor/ganglia.txt";
	//static int MAXFILESIZE = 80886080;
	static int MAXFILESIZE = 100;
	
	public TaskThread(ServletContext context) {
		this.context = context;
	}

	public static TaskThread GetTaskThread(ServletContext context) {
		if (taskThread == null) {
			taskThread = new TaskThread(context);
		}
		return taskThread;
	}

	//
	public void run() {
		if (!isRunning) {
			isRunning = true;
			context.log("new timer thread");
			try {
				// Daemon����Ϣֱ����/Rainbow/src/cn/ac/ict/servlet/MonitorServlet.java������ȡ�浽Mobean
				GetMemCache();
				// ����shell����ȡjson��Ϣ������Mobean��
				GetGanglia();
				// ����shell����ȡjson��Ϣ������Mobean�С�
			} catch (IOException e) {
				e.printStackTrace();
			} catch (ParserConfigurationException e) {
				// TODO �Զ����ɵ� catch ��
				e.printStackTrace();
			} catch (SAXException e) {
				// TODO �Զ����ɵ� catch ��
				e.printStackTrace();
			}
			try {
				MonitorToHDFS();
			} catch (IOException e) {
				// TODO �Զ����ɵ� catch ��
				e.printStackTrace();
			}
			isRunning = false;
		} else {
			context.log("last is running");
		}
	}

	private void MonitorToHDFS() throws IOException {
		// TODO �Զ����ɵķ������
		// ���ȱ���MonitorBean��Ȼ��ѡ��������д��append.txt������������д�벻ͬ���ļ���
		// ��д�뱾�ش���
		// ����HashMap
		context.log("write data to txt");
		String key;
		MonitorBean bean;
		String D_json = "\"Daemon\":\"";
		String M_json = "\"Memcache\":[";
		String G_json = "\"Ganglia\":";
		Iterator<Entry<String, MonitorBean>> iterator = MonitorMap.MoMap
				.entrySet().iterator();
		while (iterator.hasNext()) {
			Entry<String, MonitorBean> entry = iterator.next();
			key = entry.getKey();
			bean = entry.getValue();
			if (key.endsWith("D")) {
				D_json += bean.getJson();
			} else if (key.endsWith("M")) {
				M_json += bean.getJson();
				M_json += ",";
			} else if (key.endsWith("G"))
			// TODO:��Gangliadao��ʽ��ת��Ϊjson��ʽ��
			{
				G_json += bean.getJson();
			}
		}
		try {
			FileWriter daemon_fw = new FileWriter(daemon_localpath, true);
			daemon_fw.write(D_json);
			daemon_fw.write("\n");
			daemon_fw.flush();
			daemon_fw.close();
			FileWriter memcache_fw = new FileWriter(memcache_localpath, true);
			memcache_fw.write(M_json);
			memcache_fw.write("\n");
			memcache_fw.flush();
			memcache_fw.close();
			FileWriter ganglia_fw = new FileWriter(ganglia_localpath, true);
			ganglia_fw.write(G_json);
			ganglia_fw.write("\n");
			ganglia_fw.flush();
			ganglia_fw.close();
		} catch (IOException e1) {
			// TODO �Զ����ɵ� catch ��
			e1.printStackTrace();
		}
		File daemon_file = new File(daemon_localpath);
		File memcache_file = new File(memcache_localpath);
		File ganglia_file = new File(ganglia_localpath);
		// �������80M����д��HDFS
		if (daemon_file.length() >= MAXFILESIZE) {
			context.log("write daemon to HDFS");
			FileCopy(daemon_localpath, daemon_copypath);
			appendToHDFS(daemon_hdfs_path, daemon_copypath);
		}
		if (memcache_file.length() >= MAXFILESIZE) {
			context.log("write memcache to HDFS");
			FileCopy(memcache_localpath, memcache_copypath);
			appendToHDFS(memcache_hdfs_path, memcache_copypath);
		}
		if (ganglia_file.length() >= MAXFILESIZE) {
			context.log("write ganglia to HDFS");
			FileCopy(ganglia_localpath, ganglia_copypath);
			appendToHDFS(ganglia_hdfs_path, ganglia_copypath);
		}
	}

	private void GetMemCache() throws IOException {
		// TODO �Զ����ɵķ������
		StringBuffer sb;
		for (int i = 0; i < serverList.length; ++i) {
			String shPath_jsonRes = "/root/wanghao/getJsonRes.sh ";
			String cmd_jsonRes[] = { "/bin/sh", "-c",
					shPath_jsonRes + serverList[i] };
			MonitorBean Mobean;
			Process process = Runtime.getRuntime().exec(cmd_jsonRes);
			try {
				process.waitFor();

				BufferedReader br_json = new BufferedReader(
						new InputStreamReader(process.getInputStream()));

				String line_json;
				sb = new StringBuffer();
				while ((line_json = br_json.readLine()) != null)
					sb.append(line_json);
				Mobean = new MonitorBean();
				Mobean.setAppName("Memcache");
				Mobean.setIP(serverList[i]);
				Mobean.setJson(sb.toString());
				Mobean.setLastTime(getCurMiSec());
				MonitorMap.MoMap.put(serverList[i] + "M", Mobean);

			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}

	private void GetGanglia() throws IOException, ParserConfigurationException,
			SAXException {
		// TODO �Զ����ɵķ������
		StringBuffer sb = new StringBuffer();
		MonitorBean Mobean;
		String shPath = "/root/wanghao/gangliaXmlToJson.sh";
		String cmd[] = { "/bin/sh", "-c", shPath };
		Process process = Runtime.getRuntime().exec(cmd);
		BufferedReader br = new BufferedReader(new InputStreamReader(
				process.getInputStream()));
		String line;
		try {
			process.waitFor();
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
			Mobean = new MonitorBean();
			Mobean.setAppName("Ganglia");
			Mobean.setJson(sb.toString());
			Mobean.setLastTime(getCurMiSec());
			MonitorMap.MoMap.put("G", Mobean);

		} catch (InterruptedException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
	}

	public void FileCopy(String s_path, String t_path) {
		// sԴ�ļ� tĿ���ļ�
		File s = new File(s_path);
		File t = new File(t_path);
		FileInputStream fi = null;
		FileOutputStream fo = null;
		FileChannel in = null;
		FileChannel out = null;
		try {
			fi = new FileInputStream(s);
			fo = new FileOutputStream(t);
			in = fi.getChannel();// �õ���Ӧ���ļ�ͨ��
			out = fo.getChannel();// �õ���Ӧ���ļ�ͨ��
			in.transferTo(0, in.size(), out);// ��������ͨ�������Ҵ�inͨ����ȡ��Ȼ��д��outͨ��
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				s.delete();
				fi.close();
				in.close();
				fo.close();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	private void appendToHDFS(String hdfs_path,String inpath) throws IOException
	{
		String cmd="hdfs dfs -appendToFile "+inpath+" hdfs://10.10.108.72:9000" + hdfs_path;
		Process process = Runtime.getRuntime().exec(cmd);
		try {
			process.waitFor();
		} catch (InterruptedException e) {
			// TODO �Զ����ɵ� catch ��
			e.printStackTrace();
		}
		process.destroy();
	}
	/** ��ȡ��ǰֱ�������ʱ��ֵ */
	public static String getCurMiSec() {
		java.text.DateFormat formattor = new java.text.SimpleDateFormat(
				"yyyy-MM-dd hh:mm:ss");
		String date_time = formattor.format(new Date());
		return date_time;
	}

}