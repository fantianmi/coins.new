package com.mvc.entity;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import com.mvc.util.MD5Util;

@Entity
@Table(name = "btc_user")
public class Btc_user implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Basic(optional = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "uid", nullable = false)
	private Integer uid;
	@Column(name = "uusername")
	private String uusername;
	@Column(name = "upassword")
	private String upassword;
	@Column(name="uemail")
	private String uemail;
	@Column(name="uname")
	private String uname;
	@Column(name="usdtime")
	private String usdtime;
	@Column(name="ustatus")
	private String ustatus;
	@Column(name="uvalidateCode")
	private String uvalidateCode;
	@Column(name="uphone")
	private String uphone;
	@Column(name="utpassword")
	private String utpasswod;
	@Column(name="usafequestion")
	private String usafequestion;
	@Column(name="usafequestionanswer")
	private String usafequestionanswer;
	@Column(name="ucertificationcategory")
	private String ucertificationcategory;
	@Column(name="ucertification")
	private String ucertification;
	@Column(name="upstate")
	private String upstate;
	@Column(name="urole")
	private String urole;
	@Column(name="rget")
	private String rget;
	@Column(name="rengouget")
	private BigDecimal rengouget;
	@Column(name="grade")
	private Integer grade;
	@Column(name="head")
	private String head;
	//推荐人id
	@Column(name="recommend")
	private int recommend;
	
	
	public Integer getGrade() {
		return grade;
	}
	public void setGrade(Integer grade) {
		this.grade = grade;
	}
	public String getHead() {
		return head;
	}
	public void setHead(String head) {
		this.head = head;
	}
	public BigDecimal getRengouget() {
		return rengouget;
	}
	public void setRengouget(BigDecimal rengouget) {
		this.rengouget = rengouget;
	}
	public String getRget() {
		return rget;
	}
	public void setRget(String rget) {
		this.rget = rget;
	}
	public String getUrole() {
		return urole;
	}
	public void setUrole(String urole) {
		this.urole = urole;
	}
	public String getUpstate() {
		return upstate;
	}
	public void setUpstate(String upstate) {
		this.upstate = upstate;
	}
	
	public int getRecommend() {
		return recommend;
	}
	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}
	public String getUtpasswod() {
		return utpasswod;
	}
	public void setMD5Utpasswod(String utpasswod) {
		this.utpasswod = MD5Util.encode2hex(utpasswod);
	}
	public String getUsafequestion() {
		return usafequestion;
	}
	public void setUsafequestion(String usafequestion) {
		this.usafequestion = usafequestion;
	}
	public String getUsafequestionanswer() {
		return usafequestionanswer;
	}
	public void setUsafequestionanswer(String usafequestionanswer) {
		this.usafequestionanswer = usafequestionanswer;
	}
	public String getUcertificationcategory() {
		return ucertificationcategory;
	}
	public void setUcertificationcategory(String ucertificationcategory) {
		this.ucertificationcategory = ucertificationcategory;
	}
	public String getUcertification() {
		return ucertification;
	}
	public void setUcertification(String ucertification) {
		this.ucertification = ucertification;
	}
	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
	}
	public String getUusername() {
		return uusername;
	}
	public void setUusername(String uusername) {
		this.uusername = uusername;
	}
	public String getUpassword() {
		return upassword;
	}
	public void setMD5Upassword(String upassword) {
		this.upassword = MD5Util.encode2hex(upassword);
	}
	public String getUemail() {
		return uemail;
	}
	public void setUemail(String uemail) {
		this.uemail = uemail;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUsdtime() {
		return usdtime;
	}
	public void setUsdtime(String usdtime) {
		this.usdtime = usdtime;
	}
	public String getUstatus() {
		return ustatus;
	}
	public void setUstatus(String ustatus) {
		this.ustatus = ustatus;
	}
	public String getUvalidateCode() {
		return uvalidateCode;
	}
	public void setUvalidateCode(String uvalidateCode) {
		this.uvalidateCode = uvalidateCode;
	}
	public String getUphone() {
		return uphone;
	}
	public void setUphone(String uphone) {
		this.uphone = uphone;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
