package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProjectDao;
import entity.Project;
import net.sf.json.JSONArray;
import util.Constant;
import util.Pagination;

public class ProjectServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			String type = null;
				request.setCharacterEncoding("UTF-8");
				type = request.getParameter("type");
				if (type == null) {
					show(request, response);
				} else if ("showAdd".equals(type)) {
					showAdd(request, response);
				} else if ("add".equals(type)) {
					add(request, response);
				} else if ("showUpdate".equals(type)) {
					showUpdate(request, response);
				} else if ("update".equals(type)) {
					update(request, response);
				} else if ("update2".equals(type)) {
					update2(request, response);
				} else if ("del".equals(type)) {
					del(request, response);
				}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	public void del(HttpServletRequest request, HttpServletResponse response) {
		try {
			boolean flag = false;
			String ids = request.getParameter("ids");
			ProjectDao proDao = new ProjectDao();
			flag = proDao.del(ids);
			if (flag) {
				response.sendRedirect("project");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void update(HttpServletRequest request, HttpServletResponse response) {
		try {
			boolean flag = false;
			ProjectDao proDao = new ProjectDao();
			String pros = request.getParameter("pros");
			List<Project> pro = new ArrayList<>();
			JSONArray jsonArray = JSONArray.fromObject(pros);
			pro = (List<Project>) jsonArray.toCollection(jsonArray, Project.class);
			flag = proDao.update(pro);
			if (flag) {
				response.sendRedirect("project");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void update2(HttpServletRequest request, HttpServletResponse response) {
		try {
			PrintWriter out = response.getWriter();
			boolean flag = false;
			ProjectDao proDao = new ProjectDao();
			String pros = request.getParameter("pros");
			List<Project> pro = new ArrayList<>();
			JSONArray jsonArray = JSONArray.fromObject(pros);
			pro = (List<Project>) jsonArray.toCollection(jsonArray, Project.class);
			flag = proDao.update(pro);
			if (flag) {
				out.print(flag);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void showUpdate(HttpServletRequest request, HttpServletResponse response) {
		String ids = request.getParameter("ids");
		List<Project> pro = new ArrayList<>();
		ProjectDao proDao = new ProjectDao();
		pro = proDao.search(ids);
		request.setAttribute("pro", pro);
		try {
			request.getRequestDispatcher("WEB-INF/project/update.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void add(HttpServletRequest request, HttpServletResponse response) {
		try {
			Project pro = new Project();
			boolean flag = false;
			pro.setName(request.getParameter("name"));
			ProjectDao proDao = new ProjectDao();
			flag = proDao.add(pro);
			if (flag) {
				response.sendRedirect("project");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void showAdd(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.getRequestDispatcher("WEB-INF/project/add.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	public void show(HttpServletRequest request, HttpServletResponse response) {
		List<Project> proList = new ArrayList<>();
		Project pro = new Project();
		pro.setName(request.getParameter("name"));
		int ye = 1;
		if (request.getParameter("ye") != null) {
			ye = Integer.parseInt(request.getParameter("ye"));
		}

		ProjectDao proDao = new ProjectDao();
		int count = proDao.searchCountByDep(pro);
		Pagination p = new Pagination(ye, count, Constant.PRO_NUM_IN_PAGE, Constant.PRO_NUM_OF_PAGE);

		proList = proDao.searchByDep(pro, p.getBegin(), Constant.PRO_NUM_IN_PAGE);
		request.setAttribute("p", p);
		request.setAttribute("pro", pro);
		request.setAttribute("proList", proList);
		try {
			request.getRequestDispatcher("WEB-INF/project/project.jsp").forward(request, response);
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
