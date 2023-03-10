package com.itbank.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itbank.model.AnswerDTO;
import com.itbank.model.Paging;
import com.itbank.model.SurveyDTO;
import com.itbank.model.SurveyExampleDTO;
import com.itbank.model.SurveyFormDTO;
import com.itbank.model.SurveyPreferGenderDTO;
import com.itbank.model.SurveyPreferQuestionDTO;
import com.itbank.model.SurveyQuestionDTO;
import com.itbank.model.SurveyUserDonateRankDTO;
import com.itbank.model.SurveyUserJoinDTO;
import com.itbank.model.UserDonateDTO;
import com.itbank.repository.SurveyDAO;

@Service
public class SurveyService {

	@Autowired
	private SurveyDAO dao;

	public List<SurveyDTO> selectList(Paging paging) {
		HashMap<String, Object> param = new HashMap<String, Object>();

		param.put("offset", paging.getOffset());
		param.put("perPage", paging.getPerPage());

		return dao.selectList(param);
	}

	public SurveyDTO getSurveyDetail(int survey_idx) {
		return dao.selectOneDetail(survey_idx);
	}

	public List<SurveyQuestionDTO> getSurveyQuestion(int survey_idx) {
		return dao.selectSurveyQuestion(survey_idx);
	}

	public List<SurveyExampleDTO> getSurveyExample(int survey_idx) {
		return dao.selectSurveyExample(survey_idx);
	}

	public int addAnswer(HashMap<String, String> map) {
		return dao.insertAnswer(map);
	}

	public List<Integer> getQuestionIDX(HashMap<String, String> map) {
		return dao.selectQuestionIdx(map);
	}

	public int answerSubstr(HashMap<String, Object> resultMap) {
		return dao.insertAnswerSubstr(resultMap);
	}

	public int deleteAnswerResult(HashMap<String, Object> resultMap) {
		return dao.deleteAnswerResult(resultMap);
	}

	public int addpoint(HashMap<String, Object> resultMap) {
		return dao.insertUserPoint(resultMap);
	}

	public int addUserDonate(UserDonateDTO dto) {
		return dao.insertUserDonate(dto);
	}

	public int minusUserPoint(UserDonateDTO dto) {
		return dao.minusUserPoint(dto);
	}

	public int getUserPoint(int user_idx) {
		return dao.selectUserPoint(user_idx);
	}

	public List<SurveyDTO> getHomeSurvey() {
		return dao.selectHomeSurvey();
	}

	public int insertSurvey(SurveyDTO dto) {
		return dao.insertSurvey(dto);
	}

	public List<SurveyQuestionDTO> selectQuestionList() {
		return dao.selectQuestionList();
	}

	public int selectSurveyIdx() {
		return dao.selectSurveyIdx();
	}

	public int addQuestion(HashMap<String, String> addMap) {
		return dao.insertQuestion(addMap);
	}

	public int addExample(HashMap<String, String> addMap) {
		return dao.insertExample(addMap);
	}

	public int addNewQuestion(HashMap<String, String> addNewMap) {

		return dao.insertNewQuestion(addNewMap);
	}

	public int addNewExample(HashMap<String, String> addNewMap) {
		return dao.insertNewExample(addNewMap);
	}

	public List<SurveyDTO> selectAllList(Paging paging) {

		HashMap<String, Object> param = new HashMap<String, Object>();

		param.put("offset", paging.getOffset());
		param.put("perPage", paging.getPerPage());

		return dao.selectAllList(param);
	}

	public int modifySurvey(SurveyDTO dto) {
		return dao.updateSurvey(dto);
	}

	public int resetSurveyQuestion(int survey_idx) {
		return dao.changeSurveyQuestion(survey_idx);
	}

	public int resetSurveyExample(int survey_idx) {
		return dao.changeSurveyExample(survey_idx);
	}

	public SurveyQuestionDTO checkQuestion(int idx) {
		return dao.checkQuestion(idx);
	}

	public int deleteSurvey(int survey_idx) {
		return dao.deleteSurvey(survey_idx);
	}

	public int getSurveyCount() {
		return dao.selectSurveyCount();
	}

	public int getSurveyListCount() {
		return dao.selectSurveyListCount();
	}

	public int getSurveyListFilterCount(HashMap<String, String> test) {
		return dao.selectSurveyFilterCount(test);
	}

	public List<SurveyDTO> filterList(HashMap<String, String> test) {
		return dao.filterList(test);
	}

	@Transactional("transaciontManager")
	public int addQuestion(List<SurveyFormDTO> list, int survey_idx) {
		int qrow = 0;
		int erow = 0;

		HashMap<String, String> addMap = new HashMap<String, String>();
		addMap.put("survey_idx", survey_idx + "");

		// 이미 있는 질문을 추가한 경우
		for (int i = 0; i < list.size(); i++) {
			SurveyFormDTO dto = list.get(i);
			String question_content = dto.getQuestion_content();
			int idx = dto.getQuestion_idx();

			System.out.println(idx);
			System.out.println("질문 : " + question_content);

			List<String> example = dto.getExample_content();

			if (idx != 0) {
				addMap.put("question_idx", idx + "");
				addMap.put("question_content", question_content);
				qrow = addQuestion(addMap);

				for (int j = 0; j < example.size(); j++) {
					System.out.println("보기 [" + j + "]" + example.get(j));
					String example_content = example.get(j);
					addMap.put("example_content", example_content);

					erow = addExample(addMap);

					System.out.println("기존 질문 추가 성공 : " + qrow);
					System.out.println("보기 추가 성공 : " + erow);

				}

			}

			// 새로운 질문을 추가한 경우

			HashMap<String, String> addNewMap = new HashMap<String, String>();
			addNewMap.put("survey_idx", survey_idx + "");

			if (idx == 0) {
				addNewMap.put("question_content", question_content);
				qrow = addNewQuestion(addNewMap);
				System.out.println("질문 : " + question_content);

				for (int j = 0; j < example.size(); j++) {
					System.out.println("보기 [" + j + "]" + example.get(j));
					String example_content = example.get(j);
					addNewMap.put("example_content", example_content);

					erow = addNewExample(addNewMap);

					System.out.println("새 질문 추가 성공 : " + qrow);
					System.out.println("보기 추가 성공 : " + erow);

				}

			}

		}

		return 1;

	}

	@Transactional("transaciontManager")
	public int modifyQuestion(List<SurveyFormDTO> list, int survey_idx) {
		int qrow = 0;
		int erow = 0;

		HashMap<String, String> addMap = new HashMap<String, String>();
		addMap.put("survey_idx", survey_idx + "");

		// 기존 보기는 날려주기
		int resetExample = resetSurveyExample(survey_idx);
		int resetQuestion = resetSurveyQuestion(survey_idx);

		// 질문 상자 기준으로, 질문 번호가 같은데 내용이 다름 -> 질문을 수정한 경우임
		// 질문을 수정한 경우에는 그 질문을 새로 질문상자에 추가해줘야 하기 때문에 question_idx를 0으로 처리하고 새롭게 insert

		for (int o = 0; o < list.size(); o++) {
			SurveyFormDTO dto = list.get(o);

			if (dto.getQuestion_idx() != 0) {
				SurveyQuestionDTO old = checkQuestion(dto.getQuestion_idx());
				if (old.getQuestion_idx() == dto.getQuestion_idx()) {
					if (!old.getQuestion_content().equals(dto.getQuestion_content())) {
						dto.setQuestion_idx(0);
					}
				}
			}

			String question_content = dto.getQuestion_content();
			int idx = dto.getQuestion_idx();

			System.out.println(idx);
			System.out.println("질문 : " + question_content);

			if (idx != 0) {
				List<String> example = dto.getExample_content();
				addMap.put("question_idx", idx + "");
				addMap.put("question_content", question_content);
				qrow = addQuestion(addMap);

				for (int j = 0; j < example.size(); j++) {
					System.out.println(example.get(j));
					String example_content = example.get(j);
					addMap.put("example_content", example_content);

					erow = addExample(addMap);

				}

			}

			// 새로운 질문을 추가한 경우

			HashMap<String, String> addNewMap = new HashMap<String, String>();
			addNewMap.put("survey_idx", survey_idx + "");

			if (idx == 0) {
				List<String> example = dto.getExample_content();
				addNewMap.put("question_content", question_content);
				qrow = addNewQuestion(addNewMap);

				for (int j = 0; j < example.size(); j++) {
					System.out.println("보기 " + j + ":" + example.get(j));
					String example_content = example.get(j);
					addNewMap.put("example_content", example_content);
					erow = addNewExample(addNewMap);
				}
			}
		}

		return 1;

	}

	public HashMap<String, String> getTotalDonate() {
		return dao.selectTotalDonate();
	}

	public int judge(HashMap<String, Integer> hash) {
		return dao.judge(hash);
	}

	public List<AnswerDTO> getSurveyResult(HashMap<String, String> map) {
		return dao.selectSurveyResultList(map);
	}

	public List<SurveyUserJoinDTO> getUserJoin() {
		return dao.selectUserJoin();
	}

	public List<SurveyUserDonateRankDTO> getUserDonateRank() {
		return dao.selectUserDonateRank();
	}

	public List<SurveyPreferQuestionDTO> getSurveyPreferQuestion() {
		return dao.selectSurveyPreferQuestion();
	}

	public List<SurveyPreferQuestionDTO> getSurveyPreferGender() {
		return dao.selectSurveyPreferGender();
	}

	public List<SurveyQuestionDTO> getSurveyQuestionRanking() {
		return dao.selectSurveyQuestionRanking();
	}

	public List<SurveyPreferGenderDTO> getPreferAge() {
		return dao.selectSurveyPreferAge();
	}

	public List<SurveyPreferGenderDTO> getsurveyPreferJob() {
		return dao.selectSurveyPreferJob();
	}

}
