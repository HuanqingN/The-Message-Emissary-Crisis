package extension;

import java.io.IOException;
import java.io.ObjectInputStream.GetField;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Timer;

import javax.naming.LinkLoopException;
import javax.sound.midi.SysexMessage;

import extension.actions.Action;
import extension.actions.CardAction;
import extension.actions.CardAction1;
import extension.actions.CardAction5;
import extension.cards.ACard;
import extension.cards.Card;
import extension.data.DCards;
import extension.data.DSkill;
import extension.data.DSkillChild;
import extension.data.Globle;
import extension.data.Roles;
import extension.data.RolesChild;
import extension.manage.BattleCtrl;
import extension.util.ObjUtil;
import extension.util.Rand;
import extension.util.StringUtil;
import extension.vo.BaseVO;
import extension.vo.ReflectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
import it.gotoandplay.smartfoxserver.data.User;
import it.gotoandplay.smartfoxserver.data.UserVariable;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

public class Test {
	public enum DataBaseType{
		MYSQL(2,1),ORACLE(2,2),DB2(2,3),SQLSERVER(2,4);
		private int value1;
		private int value2;
		private DataBaseType(int value1,int value2){
			this.setValue1(value1);
			this.setValue2(value2);
		}
		public int getValue1() {
			return value1;
		}
		public void setValue1(int value1) {
			this.value1 = value1;
		}
		public int getValue2() {
			return value2;
		}
		public void setValue2(int value2) {
			this.value2 = value2;
		}
	}
	public Test(){
	}
	public static void main(String[] args) throws Exception, ClassNotFoundException, Exception {
		System.out.print(DataBaseType.MYSQL.getValue1());
		System.out.print(DataBaseType.MYSQL.getValue2());
	}
	
}
class TObject{
	public int a=0;
	public int b=0;
}