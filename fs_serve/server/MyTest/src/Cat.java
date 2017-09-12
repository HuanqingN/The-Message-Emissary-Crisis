
public class Cat extends Animal{
	public static int count=0;
	public Cat(){
		Cat.count++;
	}
	public String color="ºÚ";
	public void say() {
		super.say();
	}
	public Dog getDog(){
		return new Dog();
	}
}
