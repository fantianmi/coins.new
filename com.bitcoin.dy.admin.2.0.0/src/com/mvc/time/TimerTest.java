package com.mvc.time;
import org.springframework.stereotype.Service;
import java.util.Date;
@Service
public class TimerTest{
	public void showtime(){
	   System.out.println("现在的时间是:"+new Date());
	 }
}
