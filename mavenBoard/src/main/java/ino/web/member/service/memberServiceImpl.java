package ino.web.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ino.web.authorityCode.dao.authorityCodeDAO;
import ino.web.member.dao.memberDAO;

@Service
public class memberServiceImpl implements memberService {

	
	@Autowired
	memberDAO memberdao;
	
	
	@Override
	public boolean loginCheck(Map<String, Object> map) throws Exception {
		
		return memberdao.loginCheck(map);
	}


	@Override
	public String id_authoritylist(Map<String, Object> map) throws Exception {
		
		return memberdao.id_authoritylist(map);
	}


	@Override
	public List<Map<String, Object>> id_list(Map<String, Object> map) throws Exception {

		return memberdao.id_list(map);
		
	}

}
