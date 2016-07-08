/**
 * 
 */
package cn.ac.ict.web.listener;

import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * @author young_000
 *
 */
public class TaskTrigger implements ServletContextListener {
	private Timer timer = null;
	private TaskThread task = null;
	private TaskThreadForEdition editiontask=null;
	
	public void contextInitialized(ServletContextEvent event) {
		timer = new Timer(true);
		task = TaskThread.GetTaskThread(event.getServletContext());
		 //���ӳ٣�5s��ʱѭ��ִ�У����Լ��鿴Timer���˵��
		editiontask=TaskThreadForEdition.GetTaskThread(event.getServletContext());
		timer.schedule(task, 0, 5000);
		timer.schedule(editiontask, 0, 30000);
	}

	public void contextDestroyed(ServletContextEvent event) {
		timer.cancel();
	}
}
