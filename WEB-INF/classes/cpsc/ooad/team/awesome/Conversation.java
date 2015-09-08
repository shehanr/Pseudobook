package cpsc.ooad.team.awesome;

import java.util.ArrayList;
import java.util.Collections;

public class Conversation implements Comparable<Conversation>{
	private ArrayList<Message> messages;
	private ArrayList<User> messagingUsers;
	public Conversation(){
		messages = new ArrayList<Message>();
		messagingUsers = new ArrayList<User>();
	}

	public void addMessage(User u, String text){
		Message m = new Message(u, text);
		messages.add(m);	
	}

	public ArrayList<Message> getAllMessages(){
		Collections.sort(messages);
		return messages;
	}
	public ArrayList<User> getMessagingUsers(){
		return messagingUsers;
	}
	public void addMessagingUser(User u){
		messagingUsers.add(u);
	}
	public int compareTo(Conversation other){
		if(messages.get(messages.size()-1).getDate().before(other.messages.get(other.messages.size()-1).getDate())){
			return 1;
		}
		else{
			return -1;
		}
	}
	
}
