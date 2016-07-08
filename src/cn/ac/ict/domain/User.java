package cn.ac.ict.domain;

import java.io.Serializable;

/*
 * 用户类，保存登陆用户的信息
 * */
public class User implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8444783428120656741L;
	private String id;
	private String userName;
	private String userPwd;;
	private String email;
	private String group;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
	}


}
