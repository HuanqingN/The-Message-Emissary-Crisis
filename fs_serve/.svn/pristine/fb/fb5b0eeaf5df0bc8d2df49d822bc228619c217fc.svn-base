package extension.cards;

import java.util.ArrayList;

import extension.actions.Action;
import extension.actions.ICardAction;
//¹¦ÄÜ¿¨ÅÆ
public class ACard extends Card {
	@Override
	public void initAction() {
		Class c=null;
		try {
			c = Class.forName("extension.actions.CardAction"+getId());
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		Action a=null;
		try {
			a=(Action)c.newInstance();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		a.setOwner(getOwner());
		setActions(a);
	}
	public Boolean check() {
		setCanUse(false);
		if(getActions()!=null){
			setCanUse(getActions().check());
		}
		return getCanUse();
	}
}
