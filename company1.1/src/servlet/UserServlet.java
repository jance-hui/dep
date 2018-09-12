package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDao;
import entity.User;
import util.CreateMD5;

public class UserServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
			String type = request.getParameter("type");
			if (type == null) {
				showLogin(request, response);
			} else if ("doLogin".equals(type)) {
				doLogin(request, response);
			} else if ("showAdd".equals(type)) {
				showAdd(request, response);
			} else if ("search".equals(type)) {
				search(request, response);
			} else if ("add".equals(type)) {
				add(request, response);
			} else if ("showUpdate".equals(type)) {
				showUpdate(request, response);
			} else if ("update".equals(type)) {
				update(request, response);
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	public void showLogin(HttpServletRequest request, HttpServletResponse response) {
		try {
			Cookie[] cookies = request.getCookies();
			String name = "";
			if (cookies != null) {
				for (int i = 0; i < cookies.length; i++) {
					if ("username".equals(cookies[i].getName())) {
						name = cookies[i].getValue();
					}
				}
			}
			request.setAttribute("name", name);
			request.getRequestDispatcher("WEB-INF/user/login.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void doLogin(HttpServletRequest request, HttpServletResponse response) {
		try {
			HttpSession session = request.getSession();
			String rand = request.getParameter("rand");
	
			rand = rand.toLowerCase();
			if (rand.equals(session.getAttribute("rand"))) {

				String username = request.getParameter("username");
				String password = request.getParameter("password");
				password = CreateMD5.getMd5(password);
				User user = new User();
				user.setUsername(username);
				user.setPassword(password);
				UserDao userDao = new UserDao();
				boolean flag = userDao.search(user);

				if (flag) {
					session.setAttribute("name", username);
					Cookie cookie = new Cookie("username", username);
					// cookie的存在时间
					cookie.setMaxAge(60);
					response.addCookie(cookie);
					response.sendRedirect("main");
				} else {
					request.setAttribute("error", "pwd");
					request.getRequestDispatcher("WEB-INF/user/login.jsp").forward(request, response);
				}
			} else {
				request.setAttribute("error", "img");
				request.getRequestDispatcher("WEB-INF/user/login.jsp").forward(request, response);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ServletException e) {
			e.printStackTrace();
		}
	}

	public void showAdd(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.getRequestDispatcher("WEB-INF/user/add.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void search(HttpServletRequest request, HttpServletResponse response) {
		try {
			PrintWriter out = response.getWriter();
			String name = request.getParameter("newName");
			UserDao userDao = new UserDao();
			boolean flag = userDao.searchNew(name);
			out.print(flag);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void add(HttpServletRequest request, HttpServletResponse response) {
		String username = request.getParameter("name");
		String password = request.getParameter("pwd");
		password = CreateMD5.getMd5(password);

		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		UserDao userDao = new UserDao();
		boolean flag = userDao.add(user);
		try {
			if (flag) {
				request.setAttribute("name", username);
				request.getRequestDispatcher("WEB-INF/user/login.jsp").forward(request, response);
			} else {
				request.getRequestDispatcher("WEB-INF/user/fail.jsp").forward(request, response);
			}
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void showUpdate(HttpServletRequest request, HttpServletResponse response) {
		try {
			String name = request.getParameter("name");
			UserDao userDao = new UserDao();
			User user = userDao.search(name);
			request.setAttribute("user", user);
			request.getRequestDispatcher("WEB-INF/user/update.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void update(HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		pwd = CreateMD5.getMd5(pwd);
		User user = new User();
		user.setId(id);
		user.setUsername(name);
		user.setPassword(pwd);

		UserDao userDao = new UserDao();
		boolean flag = userDao.update(user);
		try {
			if (flag) {
				request.setAttribute("user", user);
				request.getRequestDispatcher("WEB-INF/main/index.jsp").forward(request, response);
			} else {
				request.getRequestDispatcher("WEB-INF/user/fail.jsp").forward(request, response);
			}
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
