package extension.data;
import java.util.HashMap;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement(name = "Roles")
public class Roles {
	 private List<RolesChild> rc;
	 public HashMap<Integer,RolesChild> hash=null;
	 @XmlElement(name = "role" )
	public List<RolesChild> getRc() {
		return rc;
	}

	public void setRc(List<RolesChild> rc) {
		this.rc = rc;
	}
	
	public HashMap<Integer,RolesChild> getHash(){
		if(hash==null){
			hash=new HashMap<Integer, RolesChild>();
			for(RolesChild c:rc){
				hash.put(c.getId(), c);
			}
		}
		return hash;
	}
}
