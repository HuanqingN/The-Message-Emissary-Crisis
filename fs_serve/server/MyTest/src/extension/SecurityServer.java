package extension;
import java.net.Socket;
import java.net.ServerSocket;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.BufferedReader;
import java.io.InputStreamReader;
public class SecurityServer {
	public void start() throws Exception {
		String xml = "<?xml version=\"1.0\"?>";
		xml = xml + "<cross-domain-policy>";
		xml = xml + "<allow-access-from domain=\"*\" to-ports=\"*\" />";
		xml = xml + "</cross-domain-policy>";
		ServerSocket serverSocket = new ServerSocket(5000);
		 System.out.println("等待客户端连接......");
		while (true) {
			try {
				// 新建一个连接
				Socket socket=null;
					try{
						socket = serverSocket.accept();
					}catch(IOException e){
						e.printStackTrace();
					}
				System.out.println(socket.getInetAddress().getHostAddress());
				System.out.println("连接成功......");
				BufferedReader br = new BufferedReader(new InputStreamReader(
						socket.getInputStream()));
				PrintWriter pw = new PrintWriter(socket.getOutputStream());
				// 接收用户名
				char[] by = new char[22];
				br.read(by, 0, 22);
				String head = new String(by);
				System.out.println("消息头:" + head);
				// 收到客户端的策略请求
				if (head.equals("<policy-file-request/>")) {
					pw.print(xml + "/0");
					System.out.println("返回:" + xml);
					pw.flush();
				} else {
					socket.close();
				}
			} catch (Exception e) {
				System.out.println("服务器出现异常!" + e);
			}
		}
	}
	public static void main(String[] args) {
		try {
			new SecurityServer().start();
		} catch (Exception e) {
			// System.out.println("socket异常:" + e);
		}
	}
}
