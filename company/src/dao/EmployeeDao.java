package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import entity.Department;
import entity.Employee;

public class EmployeeDao extends BaseDao {

	public boolean add(Employee emp) {
		Connection conn = null;
		Statement stat = null;
		boolean flag = false;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			int rs = stat.executeUpdate("insert into employee(name,sex,age,d_id,img) values('" + emp.getName() + "','"
					+ emp.getSex() + "'," + emp.getAge() + "," + emp.getDep().getId() + ",'" + emp.getImg() + "')");
			if (rs > 0) {
				flag = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, null);
		}
		return flag;

	}

	public Employee searchEmp(int id) {
		Employee emp = new Employee();
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			rs = stat.executeQuery(
					"select e.*,d.id as d_id,d.name as d_name,d.emp_count as d_count from employee as e left join department as d on e.d_id = d.id where e.id ="
							+ id);
			while (rs.next()) {
				emp.setId(rs.getInt("id"));
				emp.setName(rs.getString("name"));
				emp.setSex(rs.getString("sex"));
				emp.setAge(rs.getInt("age"));
				Department dep = new Department();
				dep.setId(rs.getInt("d_id"));
				dep.setName(rs.getString("d_name"));
				dep.setEmp_count(rs.getInt("d_count"));
				emp.setDep(dep);
				emp.setImg(rs.getString("img"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, rs);
		}
		return emp;
	}

	public List<Employee> searchBatch(String ids) {
		List<Employee> list = new ArrayList<>();
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			rs = stat.executeQuery(
					"select e.*,d.id as d_id,d.name as d_name,d.emp_count as d_count from employee as e left join department as d on e.d_id = d.id where e.id in("
							+ ids + ")");
			while (rs.next()) {
				Employee emp = new Employee();
				emp.setId(rs.getInt("id"));
				emp.setName(rs.getString("name"));
				emp.setSex(rs.getString("sex"));
				emp.setAge(rs.getInt("age"));
				Department dep = new Department();
				dep.setId(rs.getInt("d_id"));
				dep.setName(rs.getString("d_name"));
				dep.setEmp_count(rs.getInt("d_count"));
				emp.setDep(dep);
				emp.setImg(rs.getString("img"));
				list.add(emp);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, rs);
		}
		return list;
	}

	public boolean update(Employee emp) {
		boolean flag = false;
		Connection conn = null;
		Statement stat = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			String sql = "";
			if ("".equals(emp.getImg())) {
				sql = "update employee set name ='" + emp.getName() + "',sex ='" + emp.getSex() + "',age ="
						+ emp.getAge() + ",d_id =" + emp.getDep().getId() + " where id =" + emp.getId();
			} else {
				sql = "update employee set name ='" + emp.getName() + "',sex ='" + emp.getSex() + "',age ="
						+ emp.getAge() + ",d_id =" + emp.getDep().getId() + ",img ='" + emp.getImg() + "' where id ="
						+ emp.getId();
			}
			int rs = stat.executeUpdate(sql);
			if (rs > 0) {
				flag = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, null);
		}
		return flag;
	}

	public boolean updateBatch(List<Employee> emp) {
		boolean flag = false;
		Connection conn = null;
		Statement stat = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			for (int i = 0; i < emp.size(); i++) {
				String sql = "update employee set name ='" + emp.get(i).getName() + "',sex ='" + emp.get(i).getSex() + "',age =" + emp.get(i).getAge() + ",d_id ="+ emp.get(i).getDep().getId() + ", img = '"+emp.get(i).getImg()+"' where id =" + emp.get(i).getId();
				int rs = stat.executeUpdate(sql);
				if (rs > 0) {
					flag = true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, null);
		}
		return flag;
	}

	public boolean del(int id) {
		boolean flag = false;
		Connection conn = null;
		Statement stat = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			int rs = stat.executeUpdate("delete from employee where id =" + id + "");
			if (rs > 0) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, null);
		}
		return flag;
	}

	public boolean delBatch(String ids) {
		boolean flag = false;
		Connection conn = null;
		Statement stat = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			int rs = stat.executeUpdate("delete from employee where id in(" + ids + ")");
			if (rs > 0) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, null);
		}
		return flag;
	}

	public int searchCountByEmp(Employee emp) {
		int count = 0;
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			String where = " where 1=1 ";
			if (emp.getName() != null && !emp.getName().equals("")) {
				where += "and name ='" + emp.getName() + "'";
			}
			if (emp.getSex() != null && !emp.getSex().equals("")) {
				where += "and sex ='" + emp.getSex() + "'";
			}
			if (emp.getAge() != -1) {
				where += "and age =" + emp.getAge();
			}
			if (emp.getDep().getId() != 0) {
				where += "and d_id =" + emp.getDep().getId();
			}
			rs = stat.executeQuery("select count(*) from employee " + where);
			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, rs);
		}
		return count;
	}

	public List<Employee> searchByEmp(Employee emp, int begin, int empNumInPage) {
		List<Employee> list = new ArrayList<>();
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			String where = " where 1=1 ";
			if (emp.getName() != null && !emp.getName().equals("")) {
				where += "and e.name ='" + emp.getName() + "'";
			}
			if (emp.getSex() != null && !emp.getSex().equals("")) {
				where += "and e.sex ='" + emp.getSex() + "'";
			}
			if (emp.getAge() != -1) {
				where += "and e.age =" + emp.getAge();
			}
			if (emp.getDep().getId() != 0) {
				where += "and e.d_id =" + emp.getDep().getId();
			}
			rs = stat.executeQuery(
					"select e.*,d.id as d_id,d.name as d_name,d.emp_count as d_count from employee as e left join department as d on e.d_id = d.id "
							+ where + " limit " + begin + "," + empNumInPage + "");
			while (rs.next()) {
				Employee emps = new Employee();
				emps.setId(rs.getInt("id"));
				emps.setName(rs.getString("name"));
				emps.setSex(rs.getString("sex"));
				emps.setAge(rs.getInt("age"));
				Department dep = new Department();
				dep.setId(rs.getInt("d_id"));
				dep.setName(rs.getString("d_name"));
				dep.setEmp_count(rs.getInt("d_count"));
				emps.setDep(dep);
				emps.setImg(rs.getString("img"));
				list.add(emps);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, rs);
		}
		return list;
	}

}
