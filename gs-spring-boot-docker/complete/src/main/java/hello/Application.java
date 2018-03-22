package hello;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;


@SpringBootApplication
@RestController
public class Application {
    private static final Logger logger = LoggerFactory.getLogger(Application.class);

  private static final DateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
  private static final DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");

    @RequestMapping("/")
    public String home(HttpServletRequest request, 
        HttpServletResponse response) {
        logger.info(":home(): invoked");
        getHeadersInfo(request);
        Calendar cal = Calendar.getInstance();
        return "Backend Resource Response at: " + sdf.format(cal.getTime()) + System.getProperty("line.separator");
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    private static Map<String, String> getHeadersInfo(HttpServletRequest request) {

        Map<String, String> map = new HashMap<String, String>();

        Enumeration headerNames = request.getHeaderNames();
        while (headerNames.hasMoreElements()) {
            String key = (String) headerNames.nextElement();
            String value = request.getHeader(key);
            logger.info(":getHeadersInfo(): key=" + key + ", value=" + value);
            map.put(key, value);
        }

        return map;
    }

}
