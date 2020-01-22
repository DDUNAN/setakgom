package com.spring.mypage;

import java.util.ArrayList;

import com.spring.order.OrderVO;
import com.spring.setak.KeepVO;
import com.spring.setak.MendingVO;

public interface MypageService {
	public ArrayList<OrderVO> getOrderlist(OrderVO orderVO);

	public OrderVO selectOrder(long order_num);
	public int getOrdercount();
	public MendingVO selectMending(int repair_seq);
	public KeepVO selectKeep(int keep_seq);
}