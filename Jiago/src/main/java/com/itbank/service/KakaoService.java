package com.itbank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.repository.KakaoDao;


@Service
public class KakaoService {

	@Autowired KakaoDao kakaoDao;
	
	public int realKakaoId(String kakaoId) {
		return kakaoDao.realKakaoId(kakaoId);
	}
	
	
	
	
}
