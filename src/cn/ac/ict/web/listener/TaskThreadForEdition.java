/**
 * 
 */
package cn.ac.ict.web.listener;

import java.util.TimerTask;
import javax.servlet.ServletContext;


/**
 * 用于版本监控，隔一段时间查询一次
 * @author weilu
 * @creation 2015年9月30日
 * 
 */
public class TaskThreadForEdition extends TimerTask {
	public static TaskThreadForEdition taskThread = null;
	private static boolean isRunning = false;
	private ServletContext context = null;


	public TaskThreadForEdition(ServletContext context) {
		this.context = context;
	}

	public static TaskThreadForEdition GetTaskThread(ServletContext context) {
		if (taskThread == null) {
			taskThread = new TaskThreadForEdition(context);
		}
		return taskThread;
	}

	//
	public void run() {
		if (!isRunning) {
			isRunning = true;
			context.log("write data from to txt");
			System.out.println("thread two is running");
			searchNewEdition();
			isRunning = false;
		} else {
			context.log("上一次还未写完");
		}

	}

	private void searchNewEdition() {
		// TODO 交由黄磊做完，检测到新版本，则添加一个session保存edition信息，用户点击升级后，在后台进行升级操作
		
	
	}

}