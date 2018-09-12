package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dep2ProDao;
import dao.DepartmentDao;
import entity.Department;
import entity.Project;
import net.sf.json.JSONArray;
import util.Constant;
import util.Pagination;

public class DepartmentServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			String type = null;
			request.setCharacterEncoding("UTF-8");
			type = request.getParameter("type");
			Class class1 = this.getClass();
			Method method = class1.getMethod(type, HttpServletRequest.class, HttpServletResponse.class);
			method.invoke(this, request, response);
		} catch (UnsupportedEncodingException | NoSuchMethodException | SecurityException | IllegalAccessException
				| IllegalArgumentException | InvocationTargetException e) {
			e.printStackTrace();
		}
	}

	public void search(HttpServletRequest request, HttpServletResponse response) {
		List<Department> depList = new ArrayList<>();
		Department dep = new Department();
		dep.setName(request.getParameter("name"));
		int emp_count = -1;
		if (request.getParameter("count") != null && !"".equals(request.getParameter("count"))) {
			emp_count = Integer.parseInt(request.getParameter("count"));
		}
		dep.setEmp_count(emp_count);
		int ye = 1;
		if (request.getParameter("ye") != null) {
			ye = Integer.parseInt(request.getParameter("ye"));
		}

		DepartmentDao depDao = new DepartmentDao();
		int count = depDao.searchCountByDep(dep);
		Pagination p = new Pagination(ye, count, Constant.DEP_NUM_IN_PAGE, Constant.DEP_NUM_OF_PAGE);

		depList = depDao.searchByDep(dep, p.getBegin(), Constant.DEP_NUM_IN_PAGE);
		request.setAttribute("p", p);
		request.setAttribute("dep", dep);
		request.setAttribute("depList", depList);
		try {
			request.getRequestDispatcher("WEB-INF/department/department.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void showAdd(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.getRequestDispatcher("WEB-INF/department/add.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void add(HttpServletRequest request, HttpServletResponse response) {
		try {
			Department dep = new Department();
			boolean flag = false;
			dep.setName(request.getParameter("name"));
			dep.setEmp_count(Integer.parseInt(request.getParameter("count")));
			DepartmentDao depDao = new DepartmentDao();
			flag = depDao.add(dep);
			if (flag) {
				response.sendRedirect("department?type=search");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void showUpdate(HttpServletRequest request, HttpServletResponse response) {
		String ids = request.getParameter("ids");
		DepartmentDao depDao = new DepartmentDao();
		List<Department> dep = new ArrayList<>();
		dep = depDao.search(ids);
		request.setAttribute("dep", dep);
		try {
			request.getRequestDispatcher("WEB-INF/department/update.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void update(HttpServletRequest request, HttpServletResponse response) {
		try {
			boolean flag = false;
			String deps = request.getParameter("deps");
			List<Department> dep = new ArrayList<>();
			JSONArray jsonArray = JSONArray.fromObject(deps);
			dep = (List<Department>) jsonArray.toCollection(jsonArray, Department.class);
			DepartmentDao depDao = new DepartmentDao();
			flag = depDao.update(dep);
			if (flag) {
				response.sendRedirect("department?type=search");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void update2(HttpServletRequest request, HttpServletResponse response) {
		try {
			PrintWriter out = response.getWriter();
			boolean flag = false;
			String deps = request.getParameter("deps");
			List<Department> dep = new ArrayList<>();
			JSONArray jsonArray = JSONArray.fromObject(deps);
			dep = (List<Department>) jsonArray.toCollection(jsonArray, Department.class);
			DepartmentDao depDao = new DepartmentDao();
			flag = depDao.update(dep);
			if (flag) {
				out.print(flag);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void del(HttpServletRequest request, HttpServletResponse response) {
		try {
			boolean flag = false;
			String ids = request.getParameter("ids");
			DepartmentDao depDao = new DepartmentDao();
			flag = depDao.del(ids);
			if (flag) {
				response.sendRedirect("department?type=search");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void showPro(HttpServletRequest request, HttpServletResponse response) {
		try {
			int d_id = Integer.parseInt(request.getParameter("d_id"));
			String d_name = request.getParameter("d_name");
			Dep2ProDao dep2ProDao = new Dep2ProDao();
			List<Project> pro = dep2ProDao.searchByDepartment(d_id);
			request.setAttribute("pro", pro);
			List<Project> proNo = dep2ProDao.searchByNotDepartment(d_id);
			request.setAttribute("d_id", d_id);
			request.setAttribute("d_name", d_name);
			request.setAttribute("proNo", proNo);
			request.getRequestDispatcher("WEB-INF/department/dep-pro.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void showPro1(HttpServletRequest request, HttpServletResponse response) {
		try {
			int d_id = Integer.parseInt(request.getParameter("d_id"));
			String d_name = request.getParameter("d_name");
			Dep2ProDao dep2ProDao = new Dep2ProDao();
			List<Project> pro = dep2ProDao.searchByDepartment(d_id);
			request.setAttribute("pro", pro);
			List<Project> proNo = dep2ProDao.searchByNotDepartment(d_id);
			request.setAttribute("d_id", d_id);
			request.setAttribute("d_name", d_name);
			request.setAttribute("proNo", proNo);
			request.getRequestDispatcher("WEB-INF/department/test1.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void showPro2(HttpServletRequest request, HttpServletResponse response) {
		try {
			int d_id = Integer.parseInt(request.getParameter("d_id"));
			String d_name = request.getParameter("d_name");
			Dep2ProDao dep2ProDao = new Dep2ProDao();
			List<Project> pro = dep2ProDao.searchByDepartment(d_id);
			request.setAttribute("pro", pro);
			List<Project> proNo = dep2ProDao.searchByNotDepartment(d_id);
			request.setAttribute("d_id", d_id);
			request.setAttribute("d_name", d_name);
			request.setAttribute("proNo", proNo);
			request.getRequestDispatcher("WEB-INF/department/test2.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void showPro3(HttpServletRequest request, HttpServletResponse response) {
		try {
			int d_id = Integer.parseInt(request.getParameter("d_id"));
			String d_name = request.getParameter("d_name");
			Dep2ProDao dep2ProDao = new Dep2ProDao();
			List<Project> pro = dep2ProDao.searchByDepartment(d_id);
			request.setAttribute("pro", pro);
			List<Project> proNo = dep2ProDao.searchByNotDepartment(d_id);
			request.setAttribute("d_id", d_id);
			request.setAttribute("d_name", d_name);
			request.setAttribute("proNo", proNo);
			request.getRequestDispatcher("WEB-INF/department/test3.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void addPro(HttpServletRequest request, HttpServletResponse response) {
		try {
			PrintWriter out = response.getWriter();
			boolean flag = false;
			Dep2ProDao dep2ProDao = new Dep2ProDao();
			int d_id = Integer.parseInt(request.getParameter("d_id"));
			String[] p_id = request.getParameterValues("p_id");
			for (int i = 0; i < p_id.length; i++) {
				flag = dep2ProDao.add(d_id, p_id[i]);
			}
			if (flag) {
				out.print(flag);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void delPro(HttpServletRequest request, HttpServletResponse response) {
		try {
			PrintWriter out = response.getWriter();
			int d_id = Integer.parseInt(request.getParameter("d_id"));
			Dep2ProDao dep2ProDao = new Dep2ProDao();
			String[] p_id = request.getParameterValues("p_id");
			boolean flag = false;
			for (int i = 0; i < p_id.length; i++) {
				flag = dep2ProDao.del(d_id, p_id[i]);
			}

			if (flag) {
				out.print(flag);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		doGet(request, response);
	}
}
