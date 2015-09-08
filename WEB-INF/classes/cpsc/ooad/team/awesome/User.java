package cpsc.ooad.team.awesome;

import java.util.ArrayList;
import java.util.Collections;
import java.io.*;
import java.text.SimpleDateFormat;

/**
 *A user is an actor in the Facebook web application that can interact with other existing users.
 *The users can interact by adding each other as friends, posting on other user walls, adding comments to item,
 *sending private messages, and by joining groups with other users.  
 *@author David Chambers
*/

public class User {

  private String username;
  private String password;
  private String profilePicture;
  private BasicInformation basicInformation;
  private ArrayList<User> friends;
  private ArrayList<Group> groups;
  private ArrayList<User> pendingFriends;
  private ArrayList<Message> notifications;
  private ArrayList<Conversation> conversations;
  private ArrayList<WallPost> wallPosts;
	private int ID;
  /**
    *This is the User class constructor that will construct a this object
    *with a String username and String password. 
  */
  public User(String username, String password,int ID) {
  this.username = username;
  this.password = password;
  this.profilePicture = "http://24.media.tumblr.com/f1096b54d940b11b8a1a51438c0380b3/tumblr_mlepboX7qJ1qfdu3lo1_500.jpg";
  this.basicInformation = new BasicInformation("","","","","","");
  friends = new ArrayList<User>();
  pendingFriends = new ArrayList<User>();
  notifications = new ArrayList<Message>();
  conversations = new ArrayList<Conversation>();
  wallPosts = new ArrayList<WallPost>();
  groups = new ArrayList<Group>();
  this.ID = ID;

  //Make a directory for each user

  this.save();

  }
  /**
    *return the String username of this object.
    *@throws noUsernameFoundException If the method is called on a null or not instantiated object.
  */
  public String getUsername() {
    return username;
  }

  /**
    *Sets the username for this object. This method can be used for
    *setting the initial username when creating an account or changing the username of an account.
    *@throws invalidUsernameException if the username is already in use.
  */
  public void setUsername(String un) {
  username = un;
  this.save();
  }

  /**
    *returns the String password of this object. This can be used to validate log-in credentials.
  */
  public String getPassword() {
  return password;
  }

  /**
    *Sets the password of this object. This can be used to initialize a User's password and change it.  
  */

  public void setPassword(String pw) {
    password = pw;
    this.save();
  }
  /**
    *This will return an ArrayList of User objects that this object is currently friends with.  This can be used
    *to display relevant friend activity, profiles, and mutual friends. 
  */
  public ArrayList<User> getFriends() {
    return friends;
  }
  /**
    *This will return an ArrayList of User objects that this object is currently awaiting a pending friend request response.  
    *Use this method to display current friend request notifications for the user to accept or deny. If the ArrayList is empty
    *no pending friends will be returned.  
  */
  public ArrayList<User> getPendingFriends() {
    return pendingFriends;
  }
  /**
    *Accepts a User object as a parameter to be added to this object's ArrayList of friends.
    *@param addedFriend specifies the User object to be added to the ArrayList. 
    *@throws alreadyAddedFriendException if this User object is already in this User's ArrayList of friends.
  */
  public void addFriend(User addedFriend) {
    friends.add(addedFriend);
    this.save();
  }

  public void addGroup(Group g){
    groups.add(g);
  }

  public ArrayList<Group> getGroups(){
    return groups;
  }

  public void removeGroup(Group g){
    groups.remove(g);
  }
  /**
    *This will add a WallPost object to an ArrayList of WallPosts specific to this object. 
    *It will accept a User object and Wallpost message to add the new object with the apropriate author and 
    *wall post message. 
    *@param author specifies the User object to be associated with the WallPost object.
    *@param message specifies the text portion of the WallPost object.
  */
  public void addWallPost(User author, String message) {
  wallPosts.add(new WallPost(author, message)); 
  this.wallPostSave();
}

  /**
    *This will return an ArrayList of WallPost objects specific to this User.  This can be used to display
    *all wallposts on a User's profile page.
  */
  public ArrayList<WallPost> getAllWallPost() {
    Collections.sort(wallPosts);
    Collections.reverse(wallPosts);
    return wallPosts;
  }

  /**
    *This will set a profile picture on a User's profile page.  It will accept a String argument of profilePicture
    *to specify the pathname of an appropriate file type to be added as this User's profile image.  This string will 
    *a pathname to a unique location saved on disk.
    *@param profilePicture is a string that indicates the pathname of a picture file type saved on disk.  
    *@throws invalidPhotoFileType if the image is not one of the permitted file types.
  */
  public void setProfilePicture(String proPic, String id) {
  	boolean bool = false;
 	File thisDirectory = new File("../../public_html/profpics");
	String[] userFileNames = thisDirectory.list();

	for(int i=0; i < userFileNames.length;i++){
	if(userFileNames[i].equals(proPic)){
	  System.out.println(userFileNames[i]);		
          try{
                  String myFolderPath = "../../public_html/profpics";
                  String newFileExt = id + "_pic" + userFileNames[i].substring(userFileNames[i].length()-4,userFileNames[i].length());
		  System.out.println(newFileExt);	
                  File myFolder = new File(myFolderPath);
                  File oldFile = new File(myFolder, userFileNames[i]);
                  File newFile  = new File(myFolder, newFileExt);
 
                  bool = oldFile.renameTo(newFile);
                  if(bool){
                          this.profilePicture = ("http://rosemary.umw.edu/~bholster/profpics/" + newFileExt);
                  }
          }catch(Exception e){
                  e.printStackTrace();
          }
	}
	}
     this.save();
   }

  /**
    *This will return a String that specifies the pathname to an image of this object. This pathname will be stored 
    *on our web application's server.  If no profile picture has been uploaded on this object's account a default image pathname 
    *will be returned.     
  */
  public String getProfilePicture() {
    return profilePicture;
  }

  /**
    *This will return a BasicInformation Object specific to this object.  The BasicInformation object wil contain this User's 
    *firstname, lastname, birth-date, gender, relationship status, hobbies, and email.
  */
  public BasicInformation getBasicInformation() {
   return basicInformation;
 }

  /**
    *Takes all of the instance variables of a BasicInformation object as parameters to create a new Basic Information object.
    *@param birthday is a string that represents this User objects birth date
  */
  public void setBasicInformation(String firstName, String lastName, String birthday, String gender, String relationshipStatus, ArrayList<String> hobbies, String email) { 

}

  /**
    *This will accept a User object and String message to create a new Notification object.
    *@param author is the User object associated with this Notification object.  
    *@param message is a description of what the notification is notifying the user of.  This will be 1 of 3 notification types
    *which include a new friend, a new wallpost, or a new comment. 
  */
  public void addNotification(User author, String message) {
  	Message note = new Message(author, message);
  }


  /**
    *This will return an ArrayList of Notification objects.
    *If the ArrayList of notifications is empty no notifications will be returned. 
  */
  public ArrayList<Message> getNotifications() {
    return notifications;
  }

  /**
    *This will take a Wallpost object as a parameter and will delete it from 
    *the ArrayList of WallPosts.
    *@param wallPost is a WallPost object to be deleted.  
    *@throws noWallPostInArrayException if the wallPost is not in the ArrayList of WallPosts. 
  */
  public void deleteWallPost(String date) {
  	SimpleDateFormat formatter = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
        for(int i=0;i<wallPosts.size();i++){
                if(formatter.format(wallPosts.get(i).getDate()).equals(date)){
                        wallPosts.remove(wallPosts.get(i));
                }
        }
     this.wallPostSave();
   }

  /**
    *This will take a User object and add it to the ArrayList of Pending Friends
    *for this object.  If a user requests to be friends with another user they will be added to this
    *ArrayList.
    *@param pendingFriend is the User object specific to a pending friend request. 
    *@throws noUserInSystemException if the User object is removed from disk due to a profile deletion.
  */
  public void addPendingFriend(User pendingFriend) {
  	pendingFriends.add(pendingFriend);
        this.save();
  }

  public void removePendingFriend(User pendingFriend) {
        pendingFriends.remove(pendingFriend);
        this.save();
  }


    /**
      *This method will save an image of the current User files to disk.  If any changes to a User are made
      *the files will be updated by this method.  
    */

  	public void startConversation(User u, String message) {
    		Conversation c = new Conversation();
 		c.addMessagingUser(this);
		c.addMessagingUser(u);
		c.addMessage(this, message);
		conversations.add(c);
		u.conversations.add(c);
  	}

  public ArrayList<Conversation> getAllConversations() {
    return conversations;
  }
	public void setID(int ID){
		this.ID = ID;
	}
	public int getID(){
		return ID;
	}
	public boolean checkForConversation(User u){
		boolean hasConversation = false;
		for(int i = 0; i < conversations.size(); i++){
			if(conversations.get(i).getMessagingUsers().contains(u)){
				hasConversation = true;
			}
		}
		return hasConversation;
	} 
	public Conversation getConversation(User u){
		for(int i = 0; i < conversations.size(); i++){
			if(conversations.get(i).getMessagingUsers().contains(u)){
				return conversations.get(i);
			}
		}
		return null;
	} 
public void save() {
	try {

	//Save User files to the User directory by their ID
                System.out.println("In save!");
		//Create File object
		File f = new File("/home/bholster/tomcat/webapps/Pseudobook/UserFiles/User/" + ID +".user");
		FileWriter fw = new FileWriter(f);

		//Create a printer object
		PrintWriter pw = new PrintWriter(fw);

		//save user credentials
		pw.println("User");
		pw.println("-----");
		pw.println(username);
		pw.println(password);
		pw.println(profilePicture);
		
		//save users basic info
		pw.println("Basic Information");
		pw.println("-----------------");
		pw.println(basicInformation.getFirstName());
		pw.println(basicInformation.getLastName());
		pw.println(basicInformation.getBirthday());  //This might need to be set to string
		pw.println(basicInformation.getGender());
		pw.println(basicInformation.getRelationshipStatus());
		pw.println(basicInformation.getHobbies());

		//save users friends
		pw.println("Friends with");
		pw.println("------------");

		for(int i=0; i<friends.size(); i++){
			//add the getID method.
			pw.println(friends.get(i).getID());

		}

		//save pending friends
		pw.println("Pending Friends");
		pw.println("---------------");

		for(int i=0; i<pendingFriends.size(); i++){
			pw.println(pendingFriends.get(i).getID());
		}

		

		
		pw.close();

	} catch (Exception e) {
		System.out.println("could not save " + username);
		e.printStackTrace();
	}
  }

	
  

  public void wallPostSave(){
	try {
		//Save User files to the User directory by their ID
                System.out.println("In save!");
		//Create File object
		File f = new File("/home/bholster/tomcat/webapps/Pseudobook/UserFiles/User/" + ID +".wp");
		FileWriter fw = new FileWriter(f);

		//Create a printer object
		PrintWriter pw = new PrintWriter(fw);

		for(int i=0; i<wallPosts.size(); i++){
			pw.println("WallPosts");
			pw.println("---------");

			pw.println(wallPosts.get(i).getAuthor().getID());
			pw.println(wallPosts.get(i).getDate());
			pw.println(wallPosts.get(i).getMessage());
		

			pw.println("Likes");
			pw.println("-----");

			for(int j=0;j < wallPosts.get(i).getLikes().size(); j++){
				pw.println(wallPosts.get(i).getLikes().get(j).getID());
			}
	

			pw.println("Dislikes");
			pw.println("--------");
			
			for(int j=0; j < wallPosts.get(i).getDislikes().size(); j++){
				pw.println(wallPosts.get(i).getDislikes().get(j).getID());
			}
	

			pw.println("Comments");
			pw.println("--------");
		
			for(int j=0; j < wallPosts.get(i).getComments().size(); j++){
				pw.println(wallPosts.get(i).getComments().get(j).getAuthor().getID());
				pw.println(wallPosts.get(i).getComments().get(j).getDate());
				pw.println(wallPosts.get(i).getComments().get(j).getMessage());
			}	
		}
		

		
		pw.close();

	} catch (Exception e) {
		System.out.println("could not save " + ID +"wp");
		e.printStackTrace();
	}



  }

    /**
      *This method will hydrate the objects from User files on disk. 
    */
  public void load() {
  }

}
