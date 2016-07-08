package cn.ac.ict.domain;

import java.util.Date;

import cn.ac.ict.dao.GANGLIA_DAO;

public class MonitorBean {
	String ID;
	String IP;
	String AppName;
	String Json;
	String xml;
	GANGLIA_DAO ganglia_dao;
	String LastTime;
	Date update_time;
	public Date getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	
	
	public GANGLIA_DAO getGanglia_dao() {
		return ganglia_dao;
	}
	public void setGanglia_dao(GANGLIA_DAO ganglia_dao) {
		this.ganglia_dao = ganglia_dao;
	}


	public String getLastTime() {
		return LastTime;
	}
	public void setLastTime(String lastTime) {
		LastTime = lastTime;
	}
	public String getID() {
		return ID;
	}
	public String getXml() {
		return xml;
	}
	public void setXml(String xml) {
		this.xml = xml;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getIP() {
		return IP;
	}
	public void setIP(String iP) {
		IP = iP;
	}
	public String getAppName() {
		return AppName;
	}
	public void setAppName(String appName) {
		AppName = appName;
	}
	public String getJson() {
		return Json;
	}
	public void setJson(String json) {
		Json = json;
	}
	
}
