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
		 //无延迟，5s定时循环执行，请自己查看Timer类的说明
		timer.schedule(task, 0, 5000);

	}

	public void contextDestroyed(ServletContextEvent event) {
		timer.cancel();
	}
}
