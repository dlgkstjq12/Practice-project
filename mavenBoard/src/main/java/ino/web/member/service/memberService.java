package ino.web.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface memberService {
	
	public boolean loginCheck(Map<String, Object> map) throws Exception;
	
	public String id_authoritylist(Map<String, Object> map)throws Exception;
	
	public List<Map<String, Object>> id_list(Map<String, Object> map)throws Exception;

}
