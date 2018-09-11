package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.io.File;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dao.DepartmentDao;
import dao.EmployeeDao;
import entity.Department;
import entity.Employee;
import net.sf.json.JSONArray;
import util.Constant;
import util.Pagination;

public class EmployeeServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		try {
			String type = null;
			request.setCharacterEncoding("UTF-8");
			type = request.getParameter("type");
			if (type == null) {
				select(request, response);
			} else if ("showAdd".equals(type)) {
				showAdd(request, response);
			} else if ("showAdd2".equals(type)) {
				showAdd2(request, response);
			} else if ("add".equals(type)) {
				add(request, response);
			} else if ("add2".equals(type)) {
				add2(request, response);
			} else if ("showUpdate".equals(type)) {
				showUpdate(request, response);
			} else if ("update".equals(type)) {
				update(request, response);
			} else if ("upload".equals(type)) {
				upload(request, response);
			} else if ("showUpdateBatch".equals(type)) {
				showUpdateBatch(request, response);
			} else if ("updateBatch".equals(type)) {
				updateBatch(request, response);
			} else if ("updateBatch2".equals(type)) {
				updateBatch2(request, response);
			} else if ("del".equals(type)) {
				del(request, response);
			} else if ("delBatch".equals(type)) {
				delBatch(request, response);
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	public void select(HttpServletRequest request, HttpServletResponse response) {
		List<Employee> empList = new ArrayList<>();
		List<Department> depListAll = new ArrayList<>();
		Employee emp = new Employee();
		Department dep = new Department();
		emp.setName(request.getParameter("name"));
		int age = -1;
		if (request.getParameter("age") != null && !"".equals(request.getParameter("age"))) {
			age = Integer.parseInt(request.getParameter("age"));
		}
		emp.setAge(age);
		emp.setSex(request.getParameter("sex"));
		int dep_id = 0;
		if (request.getParameter("dep") != null && !"".equals(request.getParameter("dep"))) {
			dep_id = Integer.parseInt(request.getParameter("dep"));
		}
		dep.setId(dep_id);
		emp.setDep(dep);
		int ye = 1;

		DepartmentDao depDao = new DepartmentDao();
		depListAll = depDao.search();
		EmployeeDao empDao = new EmployeeDao();
		int count = empDao.searchCountByEmp(emp);
		if (request.getParameter("ye") != null) {
			ye = Integer.parseInt(request.getParameter("ye"));
		}
		Pagination p = new Pagination(ye, count, Constant.EMP_NUM_IN_PAGE, Constant.EMP_NUM_OF_PAGE);

		empList = empDao.searchByEmp(emp, p.getBegin(), Constant.EMP_NUM_IN_PAGE);
		request.setAttribute("p", p);
		request.setAttribute("dep", depListAll);
		request.setAttribute("emps", empList);
		request.setAttribute("emp", emp);
		try {
			request.getRequestDispatcher("WEB-INF/employee/employee.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void showAdd(HttpServletRequest request, HttpServletResponse response) {
		try {
			List<Department> depListAll = new ArrayList<>();
			DepartmentDao depDao = new DepartmentDao();
			depListAll = depDao.search();
			request.setAttribute("dep", depListAll);
			request.getRequestDispatcher("WEB-INF/employee/add.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void showAdd2(HttpServletRequest request, HttpServletResponse response) {
		try {
			List<Department> depListAll = new ArrayList<>();
			DepartmentDao depDao = new DepartmentDao();
			depListAll = depDao.search();
			request.setAttribute("dep", depListAll);
			request.getRequestDispatcher("WEB-INF/employee/add2.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void upload(HttpServletRequest request, HttpServletResponse response) {
		try {
			PrintWriter out = response.getWriter();
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List<FileItem> items = upload.parseRequest(request);
			String path = "e:/empImg/";
			String img = "";
			for (int i = 0; i < items.size(); i++) {
				FileItem item = items.get(i);
				if ("img".equals(item.getFieldName())) {
					UUID uuid = UUID.randomUUID();
					String end = item.getName().substring(item.getName().lastIndexOf("."));
					img = uuid.toString() + end;
					File savedFile = new File(path, img);
					item.write(savedFile);
				}
			}
			out.print(img);
		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void add(HttpServletRequest request, HttpServletResponse response) {
		try {
			Employee emp = new Employee();
			boolean flag = false;
			Department dep = new Department();
			emp.setName(request.getParameter("name"));
			emp.setAge(Integer.parseInt(request.getParameter("age")));
			emp.setSex(request.getParameter("sex"));
			dep.setId(Integer.parseInt(request.getParameter("dep")));
			emp.setDep(dep);
			emp.setImg(request.getParameter("img"));
			EmployeeDao empDao = new EmployeeDao();
			flag = empDao.add(emp);
			if (flag) {
				response.sendRedirect("employee");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void add2(HttpServletRequest request, HttpServletResponse response) {
		try {
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List<FileItem> items = upload.parseRequest(request);
			String path = "e:/empImg/";
			String name = "";
			String sex = "";
			int age = -1;
			int d_id = -1;
			String img = "";
			for (int i = 0; i < items.size(); i++) {
				FileItem item = items.get(i);
				if ("name".equals(item.getFieldName())) {
					name = new String(item.getString().getBytes("ISO-8859-1"), "utf-8");
				} else if ("sex".equals(item.getFieldName())) {
					sex = new String(item.getString().getBytes("ISO-8859-1"), "utf-8");
				} else if ("age".equals(item.getFieldName())) {
					String ageStr = new String(item.getString().getBytes("ISO-8859-1"), "utf-8");
					age = Integer.parseInt(ageStr);
				} else if ("dep".equals(item.getFieldName())) {
					String depStr = new String(item.getString().getBytes("ISO-8859-1"), "utf-8");
					d_id = Integer.parseInt(depStr);
				} else if ("img".equals(item.getFieldName())) {
					UUID uuid = UUID.randomUUID();
					String end = item.getName().substring(item.getName().lastIndexOf("."));
					img = uuid.toString() + end;
					File savedFile = new File(path, img);
					item.write(savedFile);
				}
			}
			Employee emp = new Employee();
			boolean flag = false;
			Department dep = new Department();
			emp.setName(name);
			emp.setAge(age);
			emp.setSex(sex);
			dep.setId(d_id);
			emp.setDep(dep);
			emp.setImg(img);
			EmployeeDao empDao = new EmployeeDao();
			flag = empDao.add(emp);
			if (flag) {
				response.sendRedirect("employee");
			}
		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void showUpdate(HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt(request.getParameter("id"));
		Employee emp = new Employee();
		List<Department> depListAll = new ArrayList<>();
		DepartmentDao depDao = new DepartmentDao();
		depListAll = depDao.search();
		request.setAttribute("dep", depListAll);
		EmployeeDao empDao = new EmployeeDao();
		emp = empDao.searchEmp(id);
		request.setAttribute("emp", emp);
		try {
			request.getRequestDispatcher("WEB-INF/employee/update.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void update(HttpServletRequest request, HttpServletResponse response) {
		try {

			boolean flag = false;
			Employee emp = new Employee();
			Department dep = new Department();
			emp.setId(Integer.parseInt(request.getParameter("id")));
			emp.setName(request.getParameter("name"));
			emp.setAge(Integer.parseInt(request.getParameter("age")));
			emp.setSex(request.getParameter("sex"));
			dep.setId(Integer.parseInt(request.getParameter("dep")));
			emp.setDep(dep);
			emp.setImg(request.getParameter("img"));
			EmployeeDao empDao = new EmployeeDao();
			flag = empDao.update(emp);
			if (flag) {
				response.sendRedirect("employee");
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void showUpdateBatch(HttpServletRequest request, HttpServletResponse response) {
		String ids = request.getParameter("ids");
		List<Department> depListAll = new ArrayList<>();
		DepartmentDao depDao = new DepartmentDao();
		depListAll = depDao.search();
		request.setAttribute("dep", depListAll);
		EmployeeDao empDao = new EmployeeDao();
		List<Employee> emp = empDao.searchBatch(ids);
		request.setAttribute("emp", emp);
		try {
			request.getRequestDispatcher("WEB-INF/employee/updateBatch.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void updateBatch(HttpServletRequest request, HttpServletResponse response) {
		try {
			String emps = request.getParameter("emps");
			EmployeeDao empDao = new EmployeeDao();
			boolean flag = false;
			JSONArray jsonArray = JSONArray.fromObject(emps);
			List<Employee> eList = (List<Employee>) jsonArray.toCollection(jsonArray, Employee.class);
			flag = empDao.updateBatch(eList);
			if (flag) {
				response.sendRedirect("employee");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void updateBatch2(HttpServletRequest request, HttpServletResponse response) {
		try {
			PrintWriter out = response.getWriter();
			String emps = request.getParameter("emps");
			EmployeeDao empDao = new EmployeeDao();
			boolean flag = false;
			JSONArray jsonArray = JSONArray.fromObject(emps);
			List<Employee> eList = (List<Employee>) jsonArray.toCollection(jsonArray, Employee.class);
			flag = empDao.updateBatch(eList);
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
			int id = Integer.parseInt(request.getParameter("id"));
			EmployeeDao empDao = new EmployeeDao();
			flag = empDao.del(id);
			if (flag) {
				response.sendRedirect("employee");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void delBatch(HttpServletRequest request, HttpServletResponse response) {
		try {
			boolean flag = false;
			String ids = request.getParameter("ids");
			EmployeeDao empDao = new EmployeeDao();
			flag = empDao.delBatch(ids);
			if (flag) {
				response.sendRedirect("employee");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		doGet(request, response);
	}
}
