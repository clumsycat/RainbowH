/**
 * 
 */
package cn.ac.ict.util;

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

	public void contextInitialized(ServletContextEvent event) {
		timer = new Timer(true);
		task = TaskThread.GetTaskThread(event.getServletContext());
		 //���ӳ٣�5s��ʱѭ��ִ�У����Լ��鿴Timer���˵��
		timer.schedule(task, 0, 5000);

	}

	public void contextDestroyed(ServletContextEvent event) {
		timer.cancel();
	}
}
