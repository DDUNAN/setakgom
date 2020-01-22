package com.spring.member;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mapper.CouponMapper;

@Service
public class CouponServiceImpl implements CouponService {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<CouponVO> getCouponList(String member_id) {
		ArrayList<CouponVO> couponList = null;
		try {
			CouponMapper couponMapper = sqlSession.getMapper(CouponMapper.class);
			couponList = couponMapper.getCouponList(member_id);
		} catch(Exception e) {
			System.out.println("쿠폰 리스트 검색 실패" + e.getMessage());
		}
		
		return couponList;
	}

	@Override
	public int getCouponCount(String member_id) {
		int count = 0;
		try {
			CouponMapper couponMapper = sqlSession.getMapper(CouponMapper.class);
			count = couponMapper.getCouponCount(member_id);
		} catch(Exception e) {
			System.out.println("쿠폰 리스트 검색 실패" + e.getMessage());
		}
		
		return count;		
	}
	
	
}
