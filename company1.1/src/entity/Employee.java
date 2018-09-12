package entity;


public class Employee {// implements 表示一个类实现了某个接口
	private String name;// 定义成员变量 name、sex、age
	private String sex;
	private int  age;
	private int  id;
	private Department dep;
	private String img;

	public Department getDep() {
		return dep;
	}

	public void setDep(Department dep) {
		this.dep = dep;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setSex(String sex) {
			this.sex = sex;
	}

	public String getSex() {
		return sex;
	}

	public void setAge(int age) {
			this.age = age;
	}

	public int  getAge() {
		return age;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}
}
