package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import entity.Department;
import entity.Employee;
import entity.Project;
import entity.Score;

public class ScoreDao extends BaseDao {
	public Score search(int id) {// 查询
		Score sc = new Score();
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			String sql = "SELECT * from v_emp_sc where s_id ="+id;
			rs = stat.executeQuery(sql);
			if (rs.next()) {
				Employee emp = new Employee();
				emp.setId(rs.getInt("e_id"));
				emp.setName(rs.getString("e_name"));
				Department dep = new Department();
				dep.setId(rs.getInt("d_id"));
				dep.setName(rs.getString("d_name"));
				emp.setDep(dep);
				Project pro = new Project();
				pro.setId(rs.getInt("p_id"));
				pro.setName(rs.getString("p_name"));
				sc.setValue((Integer)rs.getObject("value"));
				sc.setId(rs.getInt("s_id"));
				sc.setGrade(rs.getString("grade"));
				sc.setEmp(emp);			
				sc.setPro(pro);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, rs);
		}
		return sc;
	}
	public int searchCount(Score sc) {// 查询
		int count = 0;
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			String where = " where 1=1 ";
			if (sc.getEmp().getName()!=null && !"".equals(sc.getEmp().getName())) {
				where += " and e_name ='" + sc.getEmp().getName() + "'";
			}
			if (sc.getEmp().getDep().getId()!=-1) {
				where += " and d_id =" + sc.getEmp().getDep().getId() ;
			}
			if (sc.getPro().getId()!=-1) {
				where += " and p_id =" + sc.getPro().getId();
			}
			if (sc.getGrade()!=null && !"".equals(sc.getGrade())) {
				where += " and grade ='" + sc.getGrade() + "'";
			}
			String sql = "SELECT count(*) from v_emp_sc "+where;
			rs = stat.executeQuery(sql);
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, rs);
		}
		return count;
	}
	public List<Score> searchByCondition(Score sc ,int begin ,int size) {// 查询
		List<Score> list = new ArrayList<>();
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			String where = " where 1=1 ";
			if (sc.getEmp().getName()!=null && !"".equals(sc.getEmp().getName())) {
				where += " and e_name ='" + sc.getEmp().getName() + "'";
			}
			if (sc.getEmp().getDep().getId()!=-1) {
				where += " and d_id =" + sc.getEmp().getDep().getId() ;
			}
			if (sc.getPro().getId()!=-1) {
				where += " and p_id =" + sc.getPro().getId();
			}
			if (sc.getGrade()!=null && !"".equals(sc.getGrade())) {
				where += " and grade ='" + sc.getGrade() + "'";
			}
			rs = stat.executeQuery("SELECT * from v_emp_sc " + where+" limit "+begin+","+size);
			while (rs.next()) {
				Score score = new Score();
				Employee emp = new Employee();
				emp.setId(rs.getInt("e_id"));
				emp.setName(rs.getString("e_name"));
				Department dep = new Department();
				dep.setId(rs.getInt("d_id"));
				dep.setName(rs.getString("d_name"));
				emp.setDep(dep);
				Project pro = new Project();
				pro.setId(rs.getInt("p_id"));
				pro.setName(rs.getString("p_name"));
				score.setValue((Integer)rs.getObject("value"));
				score.setId(rs.getInt("s_id"));
				score.setGrade(rs.getString("grade"));
				score.setEmp(emp);			
				score.setPro(pro);
				list.add(score);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, rs);
		}
		return list;
	}

	public int add(Score sc) {// 增加
		int id = 0;
		Connection conn = null;
		Statement stat = null;
		ResultSet rss = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			String sql = "insert into score(e_id,p_id,value) values("+sc.getEmp().getId()+","+sc.getPro().getId()+","+sc.getValue()+")";
			int rs = stat.executeUpdate(sql);
			if(rs > 0) {
				sql = "select last_insert_id()";
				rss = stat.executeQuery(sql);
				while (rss.next()) {
					id = rss.getInt(1);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, rss);
		}
		return id ;
	}
	public boolean update(Score sc) {// 修改
		boolean flag = false;
		Connection conn = null;
		Statement stat = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			String sql = "update score set value = "+sc.getValue()+" where id = "+sc.getId();
			int rs = stat.executeUpdate(sql);
			if(rs >0) {
				flag = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, null);
		}
		return flag ;
	}
}
