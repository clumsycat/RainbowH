package cn.ac.ict.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.ac.ict.domain.User;

/**
 * Servlet Filter implementation class userFilter
 */
@WebFilter("/view/userFilter")
public class userFilter implements Filter {

	/**
	 * Default constructor.
	 */
	public userFilter() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		HttpServletRequest servletRequest = (HttpServletRequest) request;
		HttpServletResponse servletResponse = (HttpServletResponse) response;
		HttpSession session = ((HttpServletRequest) request).getSession();
		String path = servletRequest.getRequestURI();
		User user = (User) session.getAttribute("user");
		if (path.indexOf("Log") > -1 || path.indexOf("Register") > -1) {
			chain.doFilter(servletRequest, servletResponse);
			return;
		}
		if (user == null || user.getId() == null)
			servletResponse.sendRedirect("/Rainbow/servlet/LoginUIServlet");
		// pass the request along the filter chain
		else if (user.getGroup().equals("user") 
				&& path.indexOf("user") == -1 ) {
			String message = String
					.format("对不起，您没有权限访问！  本页将在3秒后跳到首页！！<meta http-equiv='refresh' content='3;url=%s'",
							 servletRequest.getContextPath()
									+ "/index.jsp");
			request.setAttribute("message", message);
			request.getRequestDispatcher("/view/message.jsp").forward(request,
					response);
		} else
			chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
