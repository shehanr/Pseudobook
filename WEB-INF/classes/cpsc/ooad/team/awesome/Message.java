package cpsc.ooad.team.awesome;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Message implements Comparable<Message> {

  private User author;
  private String message;
  private Date date;

  /*
  Takes the <i>User</i> object of the author, followed by a <i>String</i> for the message as arguements and then constructs 
  an <i>Item</i> object.
  */
  public Message(User author, String message) {
    this.author = author;
    this.message = message;
    this.date = new Date();
  }
  public Message(User author, String message, String date) {
    this.author = author;
    this.message = message;
    
    
    SimpleDateFormat formatter = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
    try {
        this.date = formatter.parse(date);
    } catch (Exception e) {
	System.out.println("date parsing failed, date is: " + date);
	e.printStackTrace();
    }
  }
  /*
  Returns the <i>User</i> object of the author who originally instantiated the <i>Item</i> object on which the method is 
  being called. 
  */
  public User getAuthor() {
    return author;
  }

  /*
  Returns the textual message, as a <i>String</i>, associated with the <i>Item</i> object on which this method is being 
  called.
  */
  public String getMessage() {
    return message;
  }

  /*
  Returns the time at which the <i>Item</i> on which this method is being called was instantiated as a <i>Date</i> object.
  */
  public Date getDate() {
    return date;
  }

  /*
  Takes the <i>Message</i> object passed as an arguement, which then has its date compared to the date 
  of the <i>Message</i> object on which the method is being called to the nearest millisecond. A 1 is returned if the passed 
  arguement is greater than the method caller, and a 0 is returned if the passed arguement is 
  less than the method caller. 
  */
  public int compareTo(Message other) {
  	if(date.after(other.date)){
		return 1;
  	}
  	else{
		return -1;
  	}
  }
}
