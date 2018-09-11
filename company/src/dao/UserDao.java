package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import entity.User;

public class UserDao extends BaseDao{
	public List<User> search() {
		List<User> users = new ArrayList<>();
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			rs = stat.executeQuery( "SELECT * from user");
			while (rs.next()) {
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				users.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, rs);
		}
		return users;
	}
	public User search(String username) {
		User user = new User();
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			rs = stat.executeQuery( "SELECT * from user where username = '" + username + "'");
			while (rs.next()) {
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, rs);
		}
		return user;
	}
	public boolean searchNew(String username) {
		boolean flag =false;
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			rs = stat.executeQuery( "SELECT * from user where username = '" + username + "'");
			if (rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, rs);
		}
		return flag;
	}
	public boolean search(User user) {
		boolean flag = false;
		Connection conn = null;
		Statement stat = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			String sql = "SELECT username from user where username = '" + user.getUsername() + "' and password = '" + user.getPassword() + "'";
			rs = stat.executeQuery(sql);
			if (rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, rs);
		}
		return flag;
	}
	
	public boolean update(User user) {
		boolean flag = false;
		Connection conn = null;
		Statement stat = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			int rs = stat.executeUpdate(
					"update user set username='"+user.getUsername()+"' ,password='"+user.getPassword()+"' where id = "+user.getId());
			if (rs>0) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, null);
		}
		return flag;
	}
	public boolean add(User user) {
		boolean flag = false;
		Connection conn = null;
		Statement stat = null;
		try {
			conn = getConnection();
			stat = conn.createStatement();
			int rs = stat.executeUpdate(
					"INSERT into user(username,password) value('"+user.getUsername()+"','"+user.getPassword()+"')");
			if (rs>0) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll(conn, stat, null);
		}
		return flag;
	}
}
