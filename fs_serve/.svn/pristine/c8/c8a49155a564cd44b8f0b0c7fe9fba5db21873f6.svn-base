package extension.data;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;

import javax.xml.bind.JAXBException;

import extension.tables.UserTable;

public class Globle {
	private static Roles roledata;
	private static DCards carddata;
	private static DSkill skilldata;
	private static DActions actiondata;
	private static DProps propdata;
	public static DProps getPropdata() {
		if(propdata==null){
			File f=new File("prop.xml");
			BufferedReader br=null;
			try {
				br = new BufferedReader(new InputStreamReader(new FileInputStream("C:/SmartFoxServerPRO_1.6.6/Server/javaExtensions/extension/config/prop.xml"),"UTF-8"));
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			} catch (FileNotFoundException e1) {
				e1.printStackTrace();
			}  
			String line="";
			StringBuffer  buffer = new StringBuffer();
			try {
				while((line=br.readLine())!=null){
				buffer.append(line);
				}
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			String fileContent = buffer.toString();
			try {
				propdata=(DProps)XMLHelper.xmlToObject(DProps.class, fileContent);
			} catch (JAXBException e) {
				e.printStackTrace();
			}
		}
		return propdata;
	}

	public static void setPropdata(DProps propdata) {
		Globle.propdata = propdata;
	}
	public static Roles getRoledata(){
		if(roledata==null){
			File f=new File("role.xml");
			BufferedReader br=null;
			try {
				br = new BufferedReader(new InputStreamReader(new FileInputStream("C:/SmartFoxServerPRO_1.6.6/Server/javaExtensions/extension/config/role.xml"),"UTF-8"));
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			} catch (FileNotFoundException e1) {
				e1.printStackTrace();
			}  
			String line="";
			StringBuffer  buffer = new StringBuffer();
			try {
				while((line=br.readLine())!=null){
				buffer.append(line);
				}
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			String fileContent = buffer.toString();
			try {
				roledata=(Roles)XMLHelper.xmlToObject(Roles.class, fileContent);
			} catch (JAXBException e) {
				e.printStackTrace();
			}
		}
		return roledata;
	}

	public static void setRoledata(Roles roledata) {
		Globle.roledata = roledata;
	}

	public static DCards getCarddata(){
		if(carddata==null){
			File f=new File("cards.xml");
			BufferedReader br=null;
			try {
				br = new BufferedReader(new InputStreamReader(new FileInputStream("C:/SmartFoxServerPRO_1.6.6/Server/javaExtensions/extension/config/cards.xml"),"UTF-8"));
//				br = new BufferedReader(new InputStreamReader(new FileInputStream("C:/Program Files (x86)/SmartFoxServerPRO_1.6.6/Server/javaExtensions/cards.xml"),"UTF-8"));
			} catch (Exception e1) {
				e1.printStackTrace();
			}  
			String line="";
			StringBuffer  buffer = new StringBuffer();
			try {
				while((line=br.readLine())!=null){
				buffer.append(line);
				}
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			String fileContent = buffer.toString();
			try {
				carddata=(DCards)XMLHelper.xmlToObject(DCards.class, fileContent);
			} catch (JAXBException e) {
				e.printStackTrace();
			}
		}
		return carddata;
	}

	public static void setCarddata(DCards carddata) {
		Globle.carddata = carddata;
	}

	public static DSkill getSkilldata(){
		if(skilldata==null){
			File f=new File("skills.xml");
			BufferedReader br=null;
			try {
				br = new BufferedReader(new InputStreamReader(new FileInputStream("C:/SmartFoxServerPRO_1.6.6/Server/javaExtensions/extension/config/skills.xml"),"UTF-8"));
//				br = new BufferedReader(new InputStreamReader(new FileInputStream("C:/Program Files (x86)/SmartFoxServerPRO_1.6.6/Server/javaExtensions/skills.xml"),"UTF-8"));
			} catch (UnsupportedEncodingException e1) {
				// TODO 自动生成的 catch 块
				e1.printStackTrace();
			} catch (FileNotFoundException e1) {
				// TODO 自动生成的 catch 块
				e1.printStackTrace();
			}  
			String line="";
			StringBuffer  buffer = new StringBuffer();
			try {
				while((line=br.readLine())!=null){
				buffer.append(line);
				}
			} catch (IOException e1) {
				// TODO 自动生成的 catch 块
				e1.printStackTrace();
			}
			String fileContent = buffer.toString();
			try {
				skilldata=(DSkill)XMLHelper.xmlToObject(DSkill.class, fileContent);
			} catch (JAXBException e) {
				e.printStackTrace();
			}
		}
		return skilldata;
	}

	public static void setSkilldata(DSkill skilldata) {
		Globle.skilldata = skilldata;
	}

	public static DActions getActiondata(){
		if(actiondata==null){
			File f=new File("cactions.xml");
			BufferedReader br=null;
			try {
				br = new BufferedReader(new InputStreamReader(new FileInputStream("C:/SmartFoxServerPRO_1.6.6/Server/javaExtensions/extension/config/scactions.xml"),"UTF-8"));
//				br = new BufferedReader(new InputStreamReader(new FileInputStream("C:/Program Files (x86)/SmartFoxServerPRO_1.6.6/Server/javaExtensions/cactions.xml"),"UTF-8"));
			} catch (UnsupportedEncodingException e1) {
				e1.printStackTrace();
			} catch (FileNotFoundException e1) {
				e1.printStackTrace();
			}  
			String line="";
			StringBuffer  buffer = new StringBuffer();
			try {
				while((line=br.readLine())!=null){
				buffer.append(line);
				}
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			String fileContent = buffer.toString();
			try {
				actiondata=(DActions)XMLHelper.xmlToObject(DActions.class, fileContent);
			} catch (JAXBException e) {
				e.printStackTrace();
			}
		}
		return actiondata;
	}

	public static void setActiondata(DActions actiondata) {
		Globle.actiondata = actiondata;
	}
}
