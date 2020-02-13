package com.spring.admin_chart;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.mapper.Admin_chart;

@Service
public class AdminChartServiceImpl implements AdminChartService {
	
	@Autowired
	private SqlSession sqlSession;

	// 세탁건수-하루단위
	@Override
	public int wash_count(HashMap<String, Object> map) {
		int cnt = 0;  
		try {
			Admin_chart mapper = sqlSession.getMapper(Admin_chart.class);
			cnt = mapper.wash_count(map);
		}catch(Exception e) {
			System.out.println("세탁건수 검색실패 " + e.getMessage());
		}
		
		return cnt; 
	}
	
	// 수선건수-하루단위
		@Override
		public int repair_count(HashMap<String, Object> map) {
			int cnt = 0;  
			try {
				Admin_chart mapper = sqlSession.getMapper(Admin_chart.class);
				cnt = mapper.repair_count(map);
			}catch(Exception e) {
				System.out.println("수선건수 검색실패 " + e.getMessage());
			}
			
			return cnt; 
		}
	
	// 보관건수-하루단위
	@Override
	public int keep_count(HashMap<String, Object> map) {
			int cnt = 0;  
			try {
				Admin_chart mapper = sqlSession.getMapper(Admin_chart.class);
				cnt = mapper.keep_count(map);
			}catch(Exception e) {
				System.out.println("보관건수 검색실패 " + e.getMessage());
			}
			
			return cnt; 
		}
	
	// 세탁건수-일주일단위
		public	int wash_count_week(HashMap<String, Object> map) {
			int cnt = 0;  
			try {
				Admin_chart mapper = sqlSession.getMapper(Admin_chart.class);
				cnt = mapper.wash_count_week(map);
			}catch(Exception e) {
				System.out.println("세탁건수-일주일단위 검색실패 " + e.getMessage());
			}
			
			return cnt; 
		}

}
