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
		
		//��������½�һ������Ĺ��̣��ڱ��ز��ԣ�����ͨ���Ժ��ٷŽ���
		//д�뱾���ļ�
/*		InputStream in = request.getInputStream();//��Request�л�ȡ�ļ���
        File f = new File("d:/temp","aaa.txt");				//�½��ļ�������һ�£���linux���½���ʲô���̣��ļ�ӦΪ/usr/intern/DiskMountPoint/upload/***.***���ļ�����
        FileOutputStream fos = new FileOutputStream(f);    //�ѽ��ܵ����ļ�д�뱾��

        byte[] b = new byte[1024];
        int n=0;

        while((n=in.read(b))!=-1){
           fos.write(b,0,n);
        }

        fos.close();
        in.close();*/
		
		
		
		//�ϴ���HDFS    
		//�ο�����    �������˾���������  ���û�����ԣ������׾ͺ���
		/*public class Appenddd {
    public static void main(String[] args) {
        String hdfs_path = "hdfs://10.10.108.72:9000/tmp/src.txt";//�ļ�·��
        Configuration conf = new Configuration();
        conf.setBoolean("dfs.support.append", true);

        String inpath = "/root/kbj/append.txt";
        FileSystem fs = null;
        try {
            fs = FileSystem.get(URI.create(hdfs_path), conf);
            //Ҫ׷�ӵ��ļ�����inpathΪ�ļ�
            InputStream in = new 
                  BufferedInputStream(new FileInputStream(inpath));
            OutputStream out = fs.append(new Path(hdfs_path));
            IOUtils.copyBytes(in, out, 4096, true);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}*/
		
		
		// ���ظ�ǰ�˵��ַ�
		response.setHeader("Cache-Control", "no-cache");
		java.io.OutputStream ous = response.getOutputStream();
		ous.write(ret_json.getBytes("UTF-8"));

		ous.flush();
		ous.close();
	}
}