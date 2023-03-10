package com.itbank.repository;

import org.springframework.stereotype.Repository;

@Repository
public interface KakaoDao {

	int realKakaoId(String kakaoId);

}
