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
import dao.ProjectDao;
import dao.ScoreDao;
import entity.Department;
import entity.Employee;
import entity.Project;
import entity.Score;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import util.Constant;
import util.Pagination;

public class ScoreServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			String type = null;
			response.setContentType("text/html;charset=utf-8");
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

	public void findPro(HttpServletRequest request, HttpServletResponse response) {
		try {
			PrintWriter out = response.getWriter();
			int d_id = 0;
			if (!"".equals(request.getParameter("d_id"))) {
				d_id = Integer.parseInt(request.getParameter("d_id"));
			}
			Dep2ProDao dProDao = new Dep2ProDao();
			List<Project> list = dProDao.searchByDepartment(d_id);
			JSONArray jsonArray = JSONArray.fromObject(list);
			out.print(jsonArray);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void update(HttpServletRequest request, HttpServletResponse response) {
		try {
			PrintWriter out = response.getWriter();
			boolean flag = false;
			int id = Integer.parseInt(request.getParameter("id"));
			int e_id = Integer.parseInt(request.getParameter("e_id"));
			int p_id = Integer.parseInt(request.getParameter("p_id"));
			int value = Integer.parseInt(request.getParameter("value"));
			Score sc = new Score();
			sc.setId(id);
			sc.setValue(value);
			Employee emp = new Employee();
			emp.setId(e_id);
			Project pro = new Project();
			pro.setId(p_id);
			sc.setEmp(emp);
			sc.setPro(pro);
			ScoreDao scDao = new ScoreDao();
			if (id == 0) {
				id = scDao.add(sc);
				if (id > 0) {
					flag = true;
				}
			} else {
				flag = scDao.update(sc);
			}
			Score score = scDao.search(id);
			if (flag) {
				JSON json = JSONObject.fromObject(score);
				out.print(json);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void search(HttpServletRequest request, HttpServletResponse response) {
		List<Score> scList = new ArrayList<>();
		Score sc = new Score();
		Employee emp = new Employee();
		emp.setName(request.getParameter("empName"));

		Department dep = new Department();
		int dep_id = -1;
		if (request.getParameter("dep") != null && !"".equals(request.getParameter("dep"))) {
			dep_id = Integer.parseInt(request.getParameter("dep"));
		}
		dep.setId(dep_id);
		emp.setDep(dep);

		Project pro = new Project();
		int pro_id = -1;
		if (request.getParameter("pro") != null && !"".equals(request.getParameter("pro"))) {
			pro_id = Integer.parseInt(request.getParameter("pro"));
		}
		pro.setId(pro_id);
		String grade = request.getParameter("grade");
		sc.setEmp(emp);
		sc.setPro(pro);
		sc.setGrade(grade);

		int ye = 1;
		if (request.getParameter("ye") != null) {
			ye = Integer.parseInt(request.getParameter("ye"));
		}

		ScoreDao scDao = new ScoreDao();
		int count = scDao.searchCount(sc);
		Pagination p = new Pagination(ye, count, Constant.SC_NUM_IN_PAGE, Constant.SC_NUM_OF_PAGE);

		DepartmentDao depDao = new DepartmentDao();
		scList = scDao.searchByCondition(sc, p.getBegin(), Constant.SC_NUM_IN_PAGE);
		List<Department> deps = depDao.search();
		ProjectDao proDao = new ProjectDao();
		List<Project> pros = proDao.search();
		request.setAttribute("dep", deps);
		request.setAttribute("pro", pros);
		request.setAttribute("p", p);
		request.setAttribute("sc", sc);
		request.setAttribute("scList", scList);
		try {
			request.getRequestDispatcher("WEB-INF/score/score.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void scoreShow(HttpServletRequest request, HttpServletResponse response) {
		List<Score> scList = new ArrayList<>();
		Score sc = new Score();
		Employee emp = new Employee();
		emp.setName(request.getParameter("empName"));

		Department dep = new Department();
		int dep_id = -1;
		if (request.getParameter("dep") != null && !"".equals(request.getParameter("dep"))) {
			dep_id = Integer.parseInt(request.getParameter("dep"));
		}
		dep.setId(dep_id);
		emp.setDep(dep);

		Project pro = new Project();
		int pro_id = -1;
		if (request.getParameter("pro") != null && !"".equals(request.getParameter("pro"))) {
			pro_id = Integer.parseInt(request.getParameter("pro"));
		}
		pro.setId(pro_id);
		String grade = request.getParameter("grade");
		sc.setEmp(emp);
		sc.setPro(pro);
		sc.setGrade(grade);

		int ye = 1;
		if (request.getParameter("ye") != null) {
			ye = Integer.parseInt(request.getParameter("ye"));
		}

		ScoreDao scDao = new ScoreDao();
		int count = scDao.searchCount(sc);
		Pagination p = new Pagination(ye, count, Constant.SC_NUM_IN_PAGE, Constant.SC_NUM_OF_PAGE);

		DepartmentDao depDao = new DepartmentDao();
		scList = scDao.searchByCondition(sc, p.getBegin(), Constant.SC_NUM_IN_PAGE);
		List<Department> deps = depDao.search();
		ProjectDao proDao = new ProjectDao();
		List<Project> pros = proDao.search();
		request.setAttribute("dep", deps);
		request.setAttribute("pro", pros);
		request.setAttribute("p", p);
		request.setAttribute("sc", sc);
		request.setAttribute("scList", scList);
		try {
			request.getRequestDispatcher("WEB-INF/score/show.jsp").forward(request, response);
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
