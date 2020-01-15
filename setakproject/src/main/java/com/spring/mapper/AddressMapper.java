package com.spring.mapper;

import java.util.ArrayList;

import com.spring.setak.AddressVO;

public interface AddressMapper {

	// 배송지 리스트
	ArrayList<AddressVO> getAddressList(String member_id);
	
	// 신규 배송지 추가
	int insertAddress(AddressVO avo); 
	
	// 배송지 수정
	// 배송지 삭제
	// 배송지 검색 
	
}
