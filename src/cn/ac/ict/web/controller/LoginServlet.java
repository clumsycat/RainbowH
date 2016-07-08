package cn.ac.ict.web.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.ac.ict.domain.User;
import cn.ac.ict.service.IUserService;
import cn.ac.ict.service.impl.UserServiceImpl;
@WebServlet("/servlet/LoginServlet")
public class LoginServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6230889568328305877L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//��ȡ�û���д�ĵ�¼�û���
		String username = request.getParameter("login_username");
		//��ȡ�û���д�ĵ�¼����
		String password = request.getParameter("login_password");
		
		IUserService service = new UserServiceImpl();
		//�û���¼
		User user = service.loginUser(username, password);
		System.out.println(user.getId());
		if(user.getId()==null){
			String message = String.format(
					"�Բ����û������������󣡣������µ�¼��2���Ϊ���Զ�������¼ҳ�棡��<meta http-equiv='refresh' content='2;url=%s'", 
					request.getContextPath()+"/servlet/LoginUIServlet");
			request.setAttribute("message",message);
			request.getRequestDispatcher("/view/message.jsp").forward(request, response);
			return;
		}
		//��¼�ɹ��󣬾ͽ��û��洢��session��
		request.getSession().setAttribute("user", user);
		String message = String.format(
				"��ϲ��%s,��½�ɹ�����ҳ����3���������ҳ����<meta http-equiv='refresh' content='3;url=%s'", 
				user.getUserName(),
				request.getContextPath()+"/index.jsp");
		request.setAttribute("message",message);
		request.getRequestDispatcher("/view/message.jsp").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}

