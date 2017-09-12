package extension.data;

import java.util.HashMap;
import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement(name = "skills")
public class DSkill {
	private List<DSkillChild> rc;
	public HashMap<Integer,DSkillChild> hash=null;
	 @XmlElement(name = "ski" )
	public List<DSkillChild> getRc() {
		return rc;
	}

	public void setRc(List<DSkillChild> rc) {
		this.rc = rc;
	}
	
	public HashMap<Integer,DSkillChild> getHash(){
		if(hash==null){
			hash=new HashMap<Integer, DSkillChild>();
			for(DSkillChild c:rc){
				hash.put(c.getId(), c);
			}
		}
		return hash;
	}
}