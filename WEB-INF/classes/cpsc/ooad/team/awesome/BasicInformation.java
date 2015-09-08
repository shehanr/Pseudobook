package cpsc.ooad.team.awesome;

import java.util.ArrayList;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Locale;

public class BasicInformation {

  private String firstName;
  private String lastName;
  private String birthday;
  private String gender;
  private String relationshipStatus;
  private ArrayList<String> hobbies = new ArrayList<String>();
  private String email;

  public BasicInformation(String firstName, String lastName, String bday, String gender, String relationshipStatus, String email){
    // ex format: 0101199
    this.birthday = bday;
    this.firstName = firstName;
    this.lastName = lastName;
    this.gender = gender;
    this.relationshipStatus = relationshipStatus;
    this.email = email;
  }

  public void setFirstName(String firstName){
    this.firstName = firstName; 
  }

  public void setLastName(String lastName){
    this.lastName = lastName; 
  }

  public void setBirthday(String bday) {
	this.birthday = bday;
  }

  public String getBirthday(){
    return birthday;
  }

  public void setRelationshipStatus(String relationshipStatus){
    this.relationshipStatus = relationshipStatus;
  }

  public String getRelationshipStatus(){
    return relationshipStatus;
  }

  public void addHobby(String hobby){
    hobbies.add(hobby);
  }

  public void removeHobbies(ArrayList<String> hobbiesToDelete){
    for(int i = 0; i < hobbiesToDelete.size(); i++){
      hobbies.remove(hobbiesToDelete.get(i));
    }
  }

  public ArrayList<String> getHobbies(){
    return hobbies;
  }

  public void setEmail(String email){
    this.email = email;
  }

  public String getEmail(){
    return email;
  }

  public String getFirstName(){
    return firstName;
  }

  public String getLastName(){
    return lastName;
  }
  public String getFullName(){
    String fullName = firstName + " " + lastName;
    return fullName;
  }
  public String getGender(){
    return gender;
  }
  public void setGender(String g){
	this.gender = g;
  }
}
