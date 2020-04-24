package ino.web.commonCode.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommCodeService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<HashMap<String, Object>> selectCommonCodeList(Map<String, Object> map) {
		
		return sqlSessionTemplate.selectList("selectCommonCodeList",map);
		
	}
	
	
	public List<HashMap<String, Object>> CommonCodeList() {
		
		return sqlSessionTemplate.selectList("CommonCodeList");
		
	}


	public List<HashMap<String, Object>> CommonCodeDetail(String num) {
		
		return sqlSessionTemplate.selectList("CommonCodeDetail",num);
	}


	public Map<String, Object> commonCodeInsert(Map<String, Object> map) {
		
		
		System.out.println("map"+map);
		
		int insertPro = sqlSessionTemplate.insert("CommonCodeInsert",map);
		
		System.out.println("insertPro"+insertPro);
		
		if(insertPro == 1){
			
			String result = "succes";
			map.put("result", result);
			System.out.println("result"+result);
			
			
		}else if(insertPro == 0){
			
			String result = "fail";
			map.put("result", result);
			System.out.println("result"+result);
		}
		
		return map;
		
		
	}
	
	
	public Map<String, Object> commonCodeDelete(Map<String, Object> map) {
		
	sqlSessionTemplate.delete("CommonCodeDelete", map);
		
		return map;
		
		
	}


	
}
