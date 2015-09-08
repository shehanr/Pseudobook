package cpsc.ooad.team.awesome;

import java.util.ArrayList;
import java.text.SimpleDateFormat;
import java.io.*;
public class Group {
  private User moderator;
  private String groupDescription;
  private String groupName;
  private ArrayList<User> members;
  private ArrayList<WallPost> wallPosts;
  private int ID;
  private int wallPostID;
    
  public Group(User moderator, String groupDescription, String groupName, int ID){
    this.moderator = moderator;
    this.groupDescription = groupDescription;
    this.groupName = groupName;
    wallPosts = new ArrayList<WallPost>();
    members = new ArrayList<User>();

    this.ID = ID;

    this.save();
  }

  public ArrayList<User> getMembers(){
    return members;
  }

  public void addMember(User member){

    members.add(member);
    this.save();
  }

  public User getModerator(){
    return moderator;
  }

  public void addWallPost(User author, String message){

    wallPosts.add(new WallPost(author, message));
    this.wallPostSave();    
  }

  public void deleteWallPost(String date){
    SimpleDateFormat formatter = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
        for(int i=0;i<wallPosts.size();i++){
                if(formatter.format(wallPosts.get(i).getDate()).equals(date)){
                        wallPosts.remove(wallPosts.get(i));
                }
        } 
     //call wall post save!
     this.wallPostSave();
  }

  public ArrayList getWallPosts(){
    return wallPosts;
    //call wall post save
  }

  public String getGroupDescription(){
    return groupDescription;
  }

  public String getGroupName(){
	return groupName;
  }
 
  public void setGroupName(String groupName){
	this.groupName = groupName;
        this.save();
  }

  public void setGroupDescription(String groupDescription){
    this.groupDescription = groupDescription;
    this.save();
  }

  public void removeMember(User member){
    members.remove(member);
    this.save();
  }

  public void save() {
	
	try {

		File f = new File("/home/bholster/tomcat/webapps/Pseudobook/UserFiles/Group/" + ID + 
			".group");
		
		FileWriter fw = new FileWriter(f);
		PrintWriter pw = new PrintWriter(fw);
		
		//Save Group information
		pw.println("Group");
		pw.println("-----");
		pw.println(moderator.getID());
		pw.println(groupDescription);
		pw.println(groupName);
		
		//Get group members
		pw.println("Members");
		pw.println("-------");
		for(int i=0; i<members.size();i++) {
			pw.println(members.get(i).getID());
		}


		pw.close();

	} catch (Exception e) {
			System.out.println("could not save " + ID + ".group");
	}

  }
 private void wallPostSave() {
        
	try {
                //Save User files to the User directory by their ID
		System.out.println("In save!");
                //Create File object
                File f = new File("/home/bholster/tomcat/webapps/Pseudobook/UserFiles/Group/" + ID +
			".wp");
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

                        for(int j =0; j <wallPosts.get(i).getLikes().size(); j++){
                                pw.println(wallPosts.get(i).getLikes().get(j).getID());
                        }
               

                	pw.println("Dislikes");
                	pw.println("--------");

                        for(int j=0; j < wallPosts.get(i).getDislikes().size(); j++){
                                pw.println(wallPosts.get(i).getDislikes().get(j).getID());
                        }
               

                	pw.println("Comments");
                	pw.println("--------");

                        for(int j = 0; j < wallPosts.get(i).getComments().size(); j++){
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
  public void load() {

  }
}
