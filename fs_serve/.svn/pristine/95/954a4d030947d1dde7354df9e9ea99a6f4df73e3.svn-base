package extension;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.LogRecord;

public class MyLogFamatter {
	private static String nl = System.getProperty("line.separator");

	  public String format(LogRecord record)
	  {
	    String s = "[id: " + record.getThreadID() + "] (" + formatLocation(record) + "): " + record.getMessage() + nl;

	    Throwable t = record.getThrown();

	    if (t == null) {
	      return s;
	    }
	    StackTraceElement[] elements = t.getStackTrace();
	    StringBuffer sb = new StringBuffer(s);
	    sb.append(" ").append(t.toString()).append(nl);

	    for (int i = 0; i < elements.length; i++)
	    {
	      StackTraceElement element = elements[i];
	      sb.append("\t").append(element.toString()).append(nl);
	    }

	    return sb.toString();
	  }

	  private String formatLocation(LogRecord record)
	  {
	    String className = record.getSourceClassName();
	    int idx = className.lastIndexOf(".");
	    if (idx != -1)
	      className = className.substring(idx + 1);
	    return className + "." + record.getSourceMethodName();
	  }

	  private String formatTime(LogRecord record)
	  {
	    SimpleDateFormat fmt = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss.SSS");
	    return fmt.format(new Date(record.getMillis()));
	  }
}
