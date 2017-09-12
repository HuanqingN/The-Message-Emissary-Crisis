package extension.vo;

public class ReflectVO {
	public Object obj=null;
	public Class[] clz=null;
	public Object[] param=null;
	public String cmd=null;
	public int dur;
	
	@Override
	public String toString() {
		return "ReflectVO::cmd:"+cmd+" obj:"+obj+" param:"+param+" clz:"+clz;
	}

	public void setParams(Object... args){
		param=args;
	}
	
	public void setClass(Class... args){
		clz=args;
	}
	
	public ReflectVO(String cmd,Object obj){
		this.obj=obj;
		this.cmd=cmd;
	}
	public ReflectVO(String cmd,Object obj,int dur){
		this.obj=obj;
		this.cmd=cmd;
		this.dur=dur;
	}
	
}
