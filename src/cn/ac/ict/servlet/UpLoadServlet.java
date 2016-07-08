package cn.ac.ict.servlet;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URI;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpLoadServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8733238416357226535L;

	public UpLoadServlet() {
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
		
		//你可以先新建一个另外的工程，在本地测试，测试通过以后再放进来
		//写入本地文件
/*		InputStream in = request.getInputStream();//从Request中获取文件流
        File f = new File("d:/temp","aaa.txt");				//新建文件，查找一下，在linux上新建是什么流程，文件应为/usr/intern/DiskMountPoint/upload/***.***（文件名）
        FileOutputStream fos = new FileOutputStream(f);    //把接受到的文件写入本地

        byte[] b = new byte[1024];
        int n=0;

        while((n=in.read(b))!=-1){
           fos.write(b,0,n);
        }

        fos.close();
        in.close();*/
		
		
		
		//上传至HDFS    
		//参考代码    看不懂了就问邝倍靖  这个没法测试，看明白就好了
		/*public class Appenddd {
    public static void main(String[] args) {
        String hdfs_path = "hdfs://10.10.108.72:9000/tmp/src.txt";//文件路径
        Configuration conf = new Configuration();
        conf.setBoolean("dfs.support.append", true);

        String inpath = "/root/kbj/append.txt";
        FileSystem fs = null;
        try {
            fs = FileSystem.get(URI.create(hdfs_path), conf);
            //要追加的文件流，inpath为文件
            InputStream in = new 
                  BufferedInputStream(new FileInputStream(inpath));
            OutputStream out = fs.append(new Path(hdfs_path));
            IOUtils.copyBytes(in, out, 4096, true);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}*/
		
		
		// 返回给前端的字符
		response.setHeader("Cache-Control", "no-cache");
		java.io.OutputStream ous = response.getOutputStream();
		ous.write(ret_json.getBytes("UTF-8"));

		ous.flush();
		ous.close();
	}
}