public class Test3 {
	
	public int stepName=0;
	public boolean isEnd=false;
	public int count=0;
	public static void main(String[] args) {
		Test3 t=new Test3();
		t.stepName=1;
		while(!t.isEnd){
		   t.goStep(t.stepName);
		}
		
		
		
		
	}
	
	public void goStep(int sname){
		switch (sname) {
		case 1:
			A();
			break;
		case 2:
			B();
			break;
		case 3:
			C();
			break;
		}
	}
	
	public void A(){
		System.out.println("A Begin");
		stepName=2;
		System.out.println("A End \n");
	}
	
	public void B(){
		System.out.println("B Begin");
		stepName=3;
		System.out.println("B End\n");
	}
	
	public void C(){
		System.out.println("C Begin");
		stepName=1;
		if(count++ >=3){
			isEnd=true;
		}
		System.out.println("C End\n");
	}
}
