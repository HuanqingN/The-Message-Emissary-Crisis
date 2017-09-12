package extension.data;
import java.util.HashMap;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement(name = "props")
public class DProps {
	 private List<DPropChild> rc;
	 public HashMap<Integer,DPropChild> hash=null;
	 @XmlElement(name = "prop" )
	public List<DPropChild> getRc() {
		return rc;
	}

	public void setRc(List<DPropChild> rc) {
		this.rc = rc;
	}
	
	public HashMap<Integer,DPropChild> getHash(){
		if(hash==null){
			hash=new HashMap<Integer, DPropChild>();
			for(DPropChild c:rc){
				hash.put(c.getId(), c);
			}
		}
		return hash;
	}
}
