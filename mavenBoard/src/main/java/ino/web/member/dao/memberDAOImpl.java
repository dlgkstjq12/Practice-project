package ino.web.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository	//dao 관련 빈
public class memberDAOImpl implements memberDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	
	@Override
	public boolean loginCheck(Map<String, Object> map) throws Exception {
		
		//로그인한 아이디랑 비밀번호로 검색해서 검색된 아이디가 있으면 true로 리턴하고,
		//없으면 false를 리턴한다.
		
		
		String name = sqlSessionTemplate.selectOne("loginCheck", map);		
	
	//조건식 ? true일때의 값 : false일때의 값
	return (name == null) ? false : true;
		

	}

	@Override
	public String id_authoritylist(Map<String, Object> map) {
		
		String id_groupid = sqlSessionTemplate.selectOne("id_authoritylist", map);

		return id_groupid;
	}


	@Override
	public List<Map<String, Object>> id_list(Map<String, Object> map) throws Exception {
		
		return sqlSessionTemplate.selectList("id_list", map);
	}

}
