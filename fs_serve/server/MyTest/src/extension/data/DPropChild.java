package extension.data;
import javax.xml.bind.annotation.XmlAttribute;


public class DPropChild {
//	<prop id="1" tag="1" n="选人卡" t="1" cv="2000" ct="1" desc="选人卡" />
	private int id;
	private String n;
	private int tag;
	private int type;
	private int cv;
	private int ct;
	@XmlAttribute(name="id")
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	@XmlAttribute(name="tag")
	public int getTag() {
		return tag;
	}
	public void setTag(int tag) {
		this.tag = tag;
	}
	@XmlAttribute(name="t")
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	@XmlAttribute(name="cv")
	public int getCv() {
		return cv;
	}
	public void setCv(int cv) {
		this.cv = cv;
	}
	@XmlAttribute(name="ct")
	public int getCt() {
		return ct;
	}
	public void setCt(int ct) {
		this.ct = ct;
	}
	
}
