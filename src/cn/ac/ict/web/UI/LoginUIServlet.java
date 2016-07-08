package cn.ac.ict.web.UI;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * @author weilu
 *
 */
@WebServlet("/servlet/LoginUIServlet")
public class LoginUIServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -387134317452396409L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("../WEB-INF/pages/login.jsp").forward(
				request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
