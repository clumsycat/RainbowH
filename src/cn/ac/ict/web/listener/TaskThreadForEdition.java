/**
 * 
 */
package cn.ac.ict.web.listener;

import java.util.TimerTask;
import javax.servlet.ServletContext;


/**
 * ���ڰ汾��أ���һ��ʱ���ѯһ��
 * @author weilu
 * @creation 2015��9��30��
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
			context.log("��һ�λ�δд��");
		}

	}

	private void searchNewEdition() {
		// TODO ���ɻ������꣬��⵽�°汾�������һ��session����edition��Ϣ���û�����������ں�̨������������
		
	
	}

}