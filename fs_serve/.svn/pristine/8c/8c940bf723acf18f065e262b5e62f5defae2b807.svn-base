package extension.util;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

import extension.actions.Action;
import extension.skills.Skill;
import extension.tasks.TaskBase;
import extension.vo.ReflectVO;

public class ObjUtil {
	public static Object getclass(String className) throws Exception, IllegalAccessException, ClassNotFoundException//className是类名
	{
	   Object obj=Class.forName(className).newInstance(); //以String类型的className实例化类
	   return obj;
	}
	public static Skill getSkillClassByID(int id){
		Class c=null;
		try {
			c = Class.forName("extension.skills.Skill"+id);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		Skill a=null;
		try {
			a=(Skill)c.newInstance();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		return a;
	}
	public static TaskBase getTaskClassByID(int id){
		Class c=null;
		try {
			c = Class.forName("extension.tasks.Task"+id);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		TaskBase a=null;
		try {
			a=(TaskBase)c.newInstance();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		return a;
	}
	public static void shuffer(List list){
		int len=list.size();
		int rnum=0;
		for (int i = 0; i < len; i++) {
			rnum=(int)(Math.random()*len);
			Object temp=list.get(rnum);
			list.set(rnum, list.get(i));
			list.set(i, temp);
		}
	}
	
	public static Object invoke(Object obj,String cmd,Object[] param,Class[] args){
		Class<? extends Object> clazz = obj.getClass();
		Method method;
		try {
//			System.out.println("OBJUTIL:::::"+cmd);
			method = clazz.getDeclaredMethod(cmd,args);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		if(method != null){
			try {
				return method.invoke(obj,param);
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	public static Object invoke(ReflectVO rvo){
		Class<? extends Object> clazz = rvo.obj.getClass();
		Method method;
		try {
			method = clazz.getDeclaredMethod(rvo.cmd,rvo.clz);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		if(method != null){
			try {
				return method.invoke(rvo.obj,rvo.param);
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
}
