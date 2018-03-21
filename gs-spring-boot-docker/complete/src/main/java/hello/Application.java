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

@SpringBootApplication
@RestController
public class Application {

  private static final DateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
  private static final DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");

    @RequestMapping("/")
    public String home() {
        Calendar cal = Calendar.getInstance();
        return "Backend Resource Response at: " + sdf.format(cal.getTime()) + System.getProperty("line.separator");
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

}
