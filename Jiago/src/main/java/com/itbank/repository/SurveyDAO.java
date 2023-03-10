package com.itbank.repository;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.itbank.model.AnswerDTO;
import com.itbank.model.Paging;
import com.itbank.model.SurveyDTO;
import com.itbank.model.SurveyExampleDTO;
import com.itbank.model.SurveyPreferGenderDTO;
import com.itbank.model.SurveyPreferQuestionDTO;
import com.itbank.model.SurveyQuestionDTO;
import com.itbank.model.SurveyUserDonateRankDTO;
import com.itbank.model.SurveyUserJoinDTO;
import com.itbank.model.UserDonateDTO;

@Repository
public interface SurveyDAO {

   List<SurveyDTO> selectList(HashMap<String, Object> param);

   SurveyDTO selectOneDetail(int survey_idx);

   List<SurveyQuestionDTO> selectSurveyQuestion(int survey_idx);

   List<SurveyExampleDTO> selectSurveyExample(int survey_idx);

   int insertAnswer(HashMap<String, String> map);

   List<Integer> selectQuestionIdx(HashMap<String, String> map);

   int insertAnswerSubstr(HashMap<String, Object> resultMap);

   int deleteAnswerResult(HashMap<String, Object> resultMap);

   int insertUserPoint(HashMap<String, Object> resultMap);

   int insertUserDonate(UserDonateDTO dto);

   int minusUserPoint(UserDonateDTO dto);

   int selectUserPoint(int user_idx);

   List<SurveyDTO> selectHomeSurvey();

   int insertSurvey(SurveyDTO dto);

   List<SurveyQuestionDTO> selectQuestionList();
  
   int selectSurveyIdx();

   int insertQuestion(HashMap<String, String> addMap);

   int insertExample(HashMap<String, String> addMap);

   int insertNewQuestion(HashMap<String, String> addNewMap);

   int insertNewExample(HashMap<String, String> addNewMap);

   List<SurveyDTO> selectAllList(HashMap<String, Object> param);

   int updateSurvey(SurveyDTO dto);

   List<SurveyExampleDTO> selectSurveyExample(HashMap<String, String> exMap);

   int changeSurveyQuestion(int survey_idx);

   int changeSurveyExample(int survey_idx);

   SurveyQuestionDTO checkQuestion(int idx);

   int deleteSurvey(int survey_idx);

   int selectSurveyCount();
   
   int selectSurveyListCount();

   List<SurveyDTO> filterList(HashMap<String, String> test);

   int selectSurveyFilterCount(HashMap<String, String> test);

   HashMap<String, String> selectTotalDonate();

   int judge(HashMap<String, Integer> hash);

   List<AnswerDTO> selectSurveyResultList(HashMap<String, String> map);

   List<SurveyUserJoinDTO> selectUserJoin();

   List<SurveyUserDonateRankDTO> selectUserDonateRank();

   List<SurveyPreferQuestionDTO> selectSurveyPreferQuestion();

   List<SurveyPreferQuestionDTO> selectSurveyPreferGender();

   List<SurveyQuestionDTO> selectSurveyQuestionRanking();

   List<SurveyPreferGenderDTO> selectSurveyPreferAge();

   List<SurveyPreferGenderDTO> selectSurveyPreferJob();




   


   
}