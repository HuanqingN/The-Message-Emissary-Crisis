
public class Cat extends Animal{
	public static int count=0;
	public Cat(){
		Cat.count++;
	}
	public String color="��";
	public void say() {
		super.say();
	}
	public Dog getDog(){
		return new Dog();
	}
}
