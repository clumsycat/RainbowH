/**
 * 
 */
package cn.ac.ict.util;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URI;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.TimerTask;
import java.util.Map.Entry;

import javax.servlet.ServletContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IOUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import cn.ac.ict.servlet.GANGLIA_DAO;
import cn.ac.ict.servlet.MonitorBean;
import cn.ac.ict.servlet.MonitorMap;

//定时获取Memcached信息以及Ganglia
public class TaskThreadForHDFS extends TimerTask {
	public static TaskThreadForHDFS taskThread = null;
	private static boolean isRunning = false;
	private ServletContext context = null;
	static String daemon_localpath = "/root/wl/monitor/daemon.txt";
	static String memcache_localpath = "/root/wl/monitor/memcache.txt";
	static String ganglia_localpath = "/root/wl/monitor/ganglia.txt";
	static String daemon_copypath = "/root/wl/monitor/copy/daemon.txt";
	static String memcache_copypath = "/root/wl/monitor/copy/memcache.txt";
	static String ganglia_copypath = "/root/wl/monitor/copy/ganglia.txt";
	static String daemon_hdfs_path = "hdfs://10.10.108.72:9000/monitor/daemon.txt";
	static String memcache_hdfs_path = "hdfs://10.10.108.72:9000/monitor/memcache.txt";
	static String ganglia_hdfs_path = "hdfs://10.10.108.72:9000/monitor/ganglia.txt";
	static int MAXFILESIZE = 80886080;

	public TaskThreadForHDFS(ServletContext context) {
		this.context = context;
	}

	public static TaskThreadForHDFS GetTaskThread(ServletContext context) {
		if (taskThread == null) {
			taskThread = new TaskThreadForHDFS(context);
		}
		return taskThread;
	}

	//
	public void run() {
		if (!isRunning) {
			isRunning = true;
			context.log("write data from to txt");
			MonitorToHDFS();
			isRunning = false;
		} else {
			context.log("上一次还未写完");
		}

	}

	private void MonitorToHDFS() {
		// TODO 自动生成的方法存根
		File daemon_file = new File(daemon_localpath);
		File memcache_file = new File(memcache_localpath);
		File ganglia_file = new File(ganglia_localpath);
		// 如果大于80M，就写入HDFS
		if (daemon_file.length() >= MAXFILESIZE) {
			FileCopy(daemon_localpath, daemon_copypath);
			writeToHDFS(daemon_hdfs_path, daemon_localpath);
		}
		if (memcache_file.length() >= MAXFILESIZE) {
			FileCopy(memcache_localpath, memcache_copypath);
			writeToHDFS(memcache_hdfs_path, memcache_localpath);
		}
		if (ganglia_file.length() >= MAXFILESIZE) {
			FileCopy(ganglia_localpath, memcache_copypath);
			writeToHDFS(ganglia_hdfs_path, ganglia_localpath);
		}
	}

	public void FileCopy(String s_path, String t_path) {
		// s源文件 t目的文件
		File s = new File(s_path);
		File t = new File(t_path);
		FileInputStream fi = null;
		FileOutputStream fo = null;
		FileChannel in = null;
		FileChannel out = null;
		try {
			fi = new FileInputStream(s);
			fo = new FileOutputStream(t);
			in = fi.getChannel();// 得到对应的文件通道
			out = fo.getChannel();// 得到对应的文件通道
			in.transferTo(0, in.size(), out);// 连接两个通道，并且从in通道读取，然后写入out通道
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				fi.close();
				in.close();
				fo.close();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	private void writeToHDFS(String hdfs_path, String inpath) {
		// TODO 自动生成的方法存根

		Configuration conf = new Configuration();
		conf.setBoolean("dfs.support.append", true);
		FileSystem fs = null;

		try {
			// fs = FileSystem.get(conf);
			fs = FileSystem.get(URI.create(hdfs_path), conf);
			boolean fileisexist = fs.exists(new Path(hdfs_path));
			Path path = new Path(hdfs_path);

			if (!fileisexist) {
				java.io.OutputStream out = fs.create(path);
				InputStream in = new BufferedInputStream(new FileInputStream(
						inpath));

				BufferedInputStream bufin = new BufferedInputStream(in);
				int buffSize = 1024;
				ByteArrayOutputStream out1 = new ByteArrayOutputStream(buffSize);

				byte[] temp = new byte[buffSize];
				int size = 0;
				while ((size = bufin.read(temp)) != -1) {
					out1.write(temp, 0, size);
				}
				bufin.close();
				in.close();
				byte[] content = out1.toByteArray();
				out1.close();

				out.write(in.toString().getBytes());
				out.write(content);

				out.flush();
				out.close();
			} else {
				// 要追加的文件流，inpath为文件
				InputStream in = new BufferedInputStream(new FileInputStream(
						inpath));
				OutputStream out = fs.append(new Path(hdfs_path));
				IOUtils.copyBytes(in, out, 4096, true);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}