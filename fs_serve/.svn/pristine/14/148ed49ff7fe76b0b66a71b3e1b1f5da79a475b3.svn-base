package extension.data;

import java.util.HashMap;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
@XmlRootElement(name = "actions")
public class DActions {
	private List<DActionChild> rc;
	public HashMap<Integer,DActionChild> hash=null;
	 @XmlElement(name = "act" )
	public List<DActionChild> getRc() {
		return rc;
	}

	public void setRc(List<DActionChild> rc) {
		this.rc = rc;
	}
	
	public HashMap<Integer,DActionChild> getHash(){
		if(hash==null){
			hash=new HashMap<Integer, DActionChild>();
			for(DActionChild c:rc){
				hash.put(c.getId(), c);
			}
		}
		return hash;
	}
}
