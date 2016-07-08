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
@WebServlet("/servlet/RegisterUIServlet")
public class RegisterUIServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5887587443850245780L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("../WEB-INF/pages/register.jsp").forward(
				request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
