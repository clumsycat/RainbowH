package cn.ac.ict.web.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.ac.ict.domain.User;
import cn.ac.ict.exception.UserExistException;
import cn.ac.ict.service.IUserService;
import cn.ac.ict.service.impl.UserServiceImpl;
@WebServlet("/servlet/RegisterServlet")
public class RegisterServlet extends HttpServlet {

	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        //���ͻ����ύ�ı����ݷ�װ��RegisterFormBean������
	        User user = new User();
	        try {
	            user.setUserName(request.getParameter("register_username"));//�����û���Id����
	            user.setEmail(request.getParameter("register_email"));
	            user.setUserPwd(request.getParameter("register_password"));
	            user.setGroup("user");
	            System.out.println(user.getEmail());
	            IUserService service = new UserServiceImpl();
	            //����service���ṩ��ע���û�����ʵ���û�ע��
	            service.registerUser(user);   
	            System.out.println("������ע�Ჿ��");
	            String message = String.format(
	                    "ע��ɹ�����3���Ϊ���Զ�������¼ҳ�棡��<meta http-equiv='refresh' content='3;url=%s'/>", 
	                    request.getContextPath()+"/servlet/LoginUIServlet");
	            request.setAttribute("message",message);
	            request.getRequestDispatcher("/view/message.jsp").forward(request,response);

	        } catch (UserExistException e) {
	        	System.out.println("�û����Ѵ���");
				request.setAttribute("message", "ע���û��Ѵ��ڣ���");
				request.getRequestDispatcher("../WEB-INF/pages/register.jsp").forward(
						request, response);
	        } catch (Exception e) {
	        	System.out.println("�����쳣");
	            e.printStackTrace(); // �ں�̨��¼�쳣
	            request.setAttribute("message", "�Բ���ע��ʧ�ܣ���");
	            request.getRequestDispatcher("/view/message.jsp").forward(request,response);
	        }
	    }

	    public void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        doGet(request, response);
	    }

}
