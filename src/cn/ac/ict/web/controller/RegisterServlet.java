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
	        //将客户端提交的表单数据封装到RegisterFormBean对象中
	        User user = new User();
	        try {
	            user.setUserName(request.getParameter("register_username"));//设置用户的Id属性
	            user.setEmail(request.getParameter("register_email"));
	            user.setUserPwd(request.getParameter("register_password"));
	            user.setGroup("user");
	            System.out.println(user.getEmail());
	            IUserService service = new UserServiceImpl();
	            //调用service层提供的注册用户服务实现用户注册
	            service.registerUser(user);   
	            System.out.println("调用完注册部分");
	            String message = String.format(
	                    "注册成功！！3秒后为您自动跳到登录页面！！<meta http-equiv='refresh' content='3;url=%s'/>", 
	                    request.getContextPath()+"/servlet/LoginUIServlet");
	            request.setAttribute("message",message);
	            request.getRequestDispatcher("/view/message.jsp").forward(request,response);

	        } catch (UserExistException e) {
	        	System.out.println("用户名已存在");
				request.setAttribute("message", "注册用户已存在！！");
				request.getRequestDispatcher("../WEB-INF/pages/register.jsp").forward(
						request, response);
	        } catch (Exception e) {
	        	System.out.println("其他异常");
	            e.printStackTrace(); // 在后台记录异常
	            request.setAttribute("message", "对不起，注册失败！！");
	            request.getRequestDispatcher("/view/message.jsp").forward(request,response);
	        }
	    }

	    public void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        doGet(request, response);
	    }

}
