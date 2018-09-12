package listener;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import util.MyWebSocket;

public class CountListener implements HttpSessionListener{
	//session的新建
	@Override
	public void sessionCreated(HttpSessionEvent event) {
		ServletContext application = event.getSession().getServletContext();
		int num = 0;
		int distoryNum = 0;
		if(application.getAttribute("num") != null) {
			num = (Integer)application.getAttribute("num");
		}
		if(application.getAttribute("distoryNum") != null) {
			distoryNum = (Integer)application.getAttribute("distoryNum");
		}
		num++;
		distoryNum++;
		application.setAttribute("num", num);
		application.setAttribute("distoryNum", distoryNum);
		String numStr = "num:"+String.valueOf(num);
		String distoryNumStr = "distoryNum:"+String.valueOf(distoryNum);
		MyWebSocket.sendMessageAll(numStr,distoryNumStr);
		event.getSession().setMaxInactiveInterval(60);
	}

	//session的销毁
	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		ServletContext application = event.getSession().getServletContext();
		int num = 0;
		if(application.getAttribute("num") != null) {
			num = (Integer)application.getAttribute("num");
		}
		num--;
		String numStr = "num:"+String.valueOf(num);
		application.setAttribute("num", num);
		MyWebSocket.sendMessageAll(numStr,"");
	}
}
