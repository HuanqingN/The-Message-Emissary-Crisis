package extension.data;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "cards")
public class DCards {
	private List<DCardsChild> rc;
	 @XmlElement(name = "ca" )
	public List<DCardsChild> getRc() {
		return rc;
	}

	public void setRc(List<DCardsChild> rc) {
		this.rc = rc;
	}
}
