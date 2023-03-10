package com.itbank.repository;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.model.UserDTO;

@Repository
public interface UserDAO {
	
	
	UserDTO login(UserDTO account);

	int join(UserDTO user);

	int checkRealMail(String email);

	List<String> getId(String email);

	HashMap<String, String> checkId(String id);

	int update(UserDTO user);

	int newPasswordSet(UserDTO user);

	int pwUpdate(UserDTO user);
	
	String getPoint(int idx);

	String getPw(String idx);

	int quit(int idx);

	int dupId(String id);

	int joinId(String id);

	int joinName(String name);

	int getEmail(String email);

	int checkPhoneNum(String phone);

	String getTotalPoint(int userIdx);

	int setGrade(UserDTO user);

	String getGrade(int user_idx);

	int checkUserType(UserDTO user);

	UserDTO selectUser(int user_idx);


	
}
