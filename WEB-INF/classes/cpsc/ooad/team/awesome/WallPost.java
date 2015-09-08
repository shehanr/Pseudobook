package cpsc.ooad.team.awesome;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.text.SimpleDateFormat;

public class WallPost extends Message {

  private ArrayList<User> likes;
  private ArrayList<User> dislikes;
  private ArrayList<Message> comments;

  /*
  Takes the <i>User</i> object of the author, followed by a <i>String</i> for the message as arguements and then constructs 
  an <i>WallPost</i> object.
  */
  WallPost(User author, String message) {
  	super(author, message);
	this.likes = new ArrayList<User>();
	this.dislikes = new ArrayList<User>();
	this.comments = new ArrayList<Message>();
  }
  WallPost(User author, String message, String date, ArrayList<Message> com, ArrayList<User> l, ArrayList<User> d) {
       super(author, message, date);
       this.likes = l;
       this.dislikes = d;
       this.comments = com;
       
      
  }
  /*
  Returns all of the <i>Comment</i> objects currently associated with the <i>WallPost</i> object on which the method is being 
  called as an <i>ArrayList</i>. 
  */
  public ArrayList<Message> getComments() {
	Collections.sort(comments);
  	return comments;
  }

  /*
  Takes the <i>User</i> object of the author, followed by a <i>String</i> for the message as arguements and adds a <i>Comment</i>
  object to the <i>WallPost</i> object on which the method is being called.
  */
  public void addComment(User author, String message) {
  	Message c = new Message(author, message);
	  comments.add(c);
  }

  public void removeComment(String date){
	SimpleDateFormat formatter = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
        for(int i=0;i<comments.size();i++){
                if(formatter.format(comments.get(i).getDate()).equals(date)){
                        comments.remove(comments.get(i));
                }
        }
  }

  /*
  Takes the <i>User</i> object as an arguement, that liked the wall post and adds it to the <i>WallPost</i> object on which the 
  method is being called.
  */
  public void like(User author) {
    if(likes.contains(author)){
      likes.remove(author);
    }else{
  	  likes.add(author);
    }
  }

  /*
  Returns an <i>ArrayList</i> of <i>User</i> objects for all users that have liked the <i>WallPost</i> object on which the method 
  is being called.
  */
  public ArrayList<User> getLikes() {
  	return likes;
  }

  /*
  Takes the <i>User</i> object as an arguement, that disliked the wall post and adds it to the <i>WallPost</i> object on which the 
  method is being called.
  */
  public void dislike(User author) {
  	if(dislikes.contains(author)){
      dislikes.remove(author);
    }else{
      dislikes.add(author);
    }
  }

  /*
  Returns an <i>ArrayList</i> of <i>User</i> objects for all users that have disliked the <i>WallPost</i> object on which the method 
  is being called.
  */
  public ArrayList<User> getDislikes() {
  	return dislikes;
  }
}
