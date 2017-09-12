import java.net.Socket;
import java.net.ServerSocket;
import java.io.PrintWriter;
import java.io.BufferedReader;
import java.io.InputStreamReader;
 
public class XMLServel {
	public int count=0;
    public void start() throws Exception {
        String xml = "<cross-domain-policy>";
        xml = xml + "<allow-access-from domain=\"*\" to-ports=\"*\" />";
        xml = xml + "</cross-domain-policy>";
 
        ServerSocket serverSocket = new ServerSocket(5000);
        while (true) {
            try {
                // 新建一个连接
                Socket socket = serverSocket.accept();
                System.out.println("连接成功......");
                BufferedReader br = new BufferedReader(new InputStreamReader(
                        socket.getInputStream()));
                PrintWriter pw = new PrintWriter(socket.getOutputStream());
                // 接收用户名
                char[] by = new char[22];
                br.read(by, 0, 22);
                String head = new String(by);
                System.out.println("消息头:" + head + ":共"+(count++)+"个");
                if (head.equals("<policy-file-request/>")) {
                    pw.print(xml + "\0");
                    pw.flush();
                }
                /*
                 * else { ServerThread thread = new ServerThread(socket);
                 * thread.start(); }
                 */
            } catch (Exception e) {
                System.out.println("服务器出现异常！" + e);
            }
        }
    }
 
    public static void main(String[] args) {
        try {
            new XMLServel().start();
        } catch (Exception e) {
            System.out.println("socket异常:" + e);
        }
 
    }
}