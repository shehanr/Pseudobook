package cpsc.ooad.team.awesome;
import java.io.*;
import java.util.*;

/**
  *The UserRepository creates new User objects when users register for an account.  
  *The UserRepository will store all active Users in the system and will hydrate existing User objects when appropriate
  *to do so.
  *@author David Chambers
*/
public class UserRepository {

  	private static UserRepository theInstance;
	private static int idCount;
	private Hashtable<String, Integer> ids; //maps user's email to ID associated with their profile  
	private Hashtable<Integer, User> users;
  	private Hashtable<Integer, Group> groups;

  /**
    *This will call the User constructor in the User Class and will 
    *pass the String username and String password to instantiate the object with
    *@return the instantiated user object
  */
  	public User createNewUser(String username, String password) {


		idCount++;

		User u = new User(username, password, idCount);
		
	   	ids.put(username, idCount);
		users.put(idCount, u);
		u.setID(idCount);
		this.save();   	
		return u;
			
  }

	/**
	* Returns the ID number associated with the email address of a user passed in as an argument.
	* @throws noIDInSystemException if the email address is not associated with an ID in the system.

	*/
	public Integer getID(String email){
		return ids.get(email);
	}

  /**
    *This will return the user object based on the ID associated with their profile.
    *@throws noUserInSystemException if the username is not a current User on disk. 
  */
  public User getUser(int idNumber) {
  	return users.get(idNumber);
  }

  /**
    *This will return a hashtable that has the Key representing a username
    *and a value that is that users object address.  
  */
  public Collection<User> getAllUsers() {
  	return users.values();
  }

  /**
    *This will create a new Group object.
    *@param moderator is the User object that has administrative privilegs for the group
    *@param description is the String that describes the groups purpose. 
    *@return a group object
  */
  public Group createNewGroup(User moderator, String description, String groupName) {
  	idCount++;

	 Group g = new Group(moderator, description, groupName, idCount);
	ids.put(groupName, idCount);
	groups.put(idCount, g);
	this.save();
	   return g;
  }

  /**
    *This will return a hashtable with all current groups in existance
    *with the Key as a String to the Group name and a value of the address to 
    *the group object.  If there are no groups in existance it will return an empty hashtable
  */
  public Collection<Group> getAllGroups() {
  	return groups.values();
  }

  /**
    *This returns a group object which is based on the groupName parameter.  
  */
  public Group getGroup(int id) {
  	return groups.get(id);
  }

  /**
    *This is the User Repository constructor that will be called once
    *to hydrate all objects on the disk
  */
  public static synchronized UserRepository instance() {
  	if (theInstance == null) {
		theInstance = new UserRepository();
		theInstance.bootstrap();
	   }
	   return theInstance;
  }

  /**
  */

  public void save(){
	 try {

                //Create File object
                File f = new File("/home/bholster/tomcat/webapps/Pseudobook/UserFiles/" + "UserRepo" +".rp");
                FileWriter fw = new FileWriter(f);

                //Create a printer object
                PrintWriter pw = new PrintWriter(fw);

                //save user credentials
                pw.println("ID Count");
                pw.println("--------");
		pw.println(idCount);
		
		Set<Integer> keys = users.keySet(); 
		for(Integer key: keys){

			pw.println("User");
			pw.println("----");
			pw.println(key);
			pw.println(users.get(key).getUsername());
			pw.println(users.get(key).getPassword());
		}

                pw.close();
		
		                //Create File object
                File gf = new File("/home/bholster/tomcat/webapps/Pseudobook/UserFiles/" + "GroupRepo" +".rp");
                FileWriter gw = new FileWriter(gf);

                //Create a printer object
                PrintWriter gpw = new PrintWriter(gw);


                Set<Integer> iter = groups.keySet();
                for(Integer key: iter){

                        gpw.println("Group");
                        gpw.println("-----");
                        gpw.println(key);
                        gpw.println(groups.get(key).getGroupName());
                        gpw.println(groups.get(key).getGroupDescription());
                }

                gpw.close();


		
        } catch (Exception e) {
                System.out.println("could not save the repo file");
                e.printStackTrace();
        }
	

  }

 


  	public void bootstrap() {
	try{	
		//UserRepo
		System.out.println("In bootstrap, lets party");
   		File f = new File("/home/bholster/tomcat/webapps/Pseudobook/UserFiles/UserRepo.rp");
                
		FileReader fr = new FileReader(f);
		BufferedReader br = new BufferedReader(fr);
		
		//set up string line variables
		String idLine = "";
		String emailLine = "";
		String passwordLine = "";
		
		String totalUserCount ="";
		//variable to use to convert ID line from string to int
		Integer id;

		br.readLine(); //Throwing away "ID Count"
		br.readLine(); //Thorwing away "--------"
		passwordLine = br.readLine(); //Grabbing the total user count from the file
		
		System.out.println("The total user count is: " + passwordLine);
		
		 br.readLine(); //Throwing away "User"
                 br.readLine(); //Throwing away "----"

                 idLine = br.readLine();
                 System.out.println("The id is: " +  idLine);
                 emailLine = br.readLine();
                 System.out.println("The email is: " + emailLine);
                 passwordLine = br.readLine();
                 System.out.println("The password is: " + passwordLine);

                 //add to hashtable ids
                 id = Integer.valueOf(idLine);   //convert string to int to add

                 ids.put(emailLine, id);
                 users.put(id, new User(emailLine, passwordLine, id));
		


		while(idLine != null || emailLine != null || passwordLine != null){
			br.readLine(); //Throwing away "User"
			br.readLine(); //Throwing away "----"

			idLine = br.readLine(); 
			System.out.println("The id is: " +  idLine);
			emailLine = br.readLine();
			System.out.println("The email is: " + emailLine);
			passwordLine = br.readLine();
			System.out.println("The password is: " + passwordLine);

			//add to hashtable ids
			id = Integer.valueOf(idLine);	//convert string to int to add
	
			ids.put(emailLine, id);
			users.put(id, new User(emailLine, passwordLine, id));

		}
	} catch (Exception e) {
		System.out.println("Cannot save file!");
	}
	
			//GroupRepo

 




 	}

	private UserRepository(){
		ids = new Hashtable<String, Integer>();
		users = new Hashtable<Integer, User>();
		groups = new Hashtable<Integer, Group>();
		idCount = 0;
	}





}
