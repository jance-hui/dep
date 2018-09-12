package servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDao;
import entity.User;

public class MainServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
			String type = request.getParameter("type");
			if (type == null) {
				show(request, response);
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

	}

	public void show(HttpServletRequest request, HttpServletResponse response) {
		try {
			HttpSession session = request.getSession();
			String name = (String) session.getAttribute("name");
			UserDao userDao = new UserDao();
			User user = userDao.search(name);
			request.setAttribute("user", user);
			request.getRequestDispatcher("WEB-INF/main/index.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		doGet(request, response);
	}
}
