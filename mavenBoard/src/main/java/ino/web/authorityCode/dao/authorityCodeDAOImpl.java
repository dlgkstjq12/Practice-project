package ino.web.authorityCode.dao;

import java.util.HashMap;
import java.util.List;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.mybatis.spring.SqlSessionTemplate;

@Repository	//dao 관련 빈
@Transactional
public class authorityCodeDAOImpl implements authorityCodeDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<HashMap<String, Object>> authorityCodeList() throws Exception {
	
		return sqlSessionTemplate.selectList("authorityCodeList");
	}

	@Override
	public List<Map<String, Object>> authorityCodeSearchlist(Map<String, Object> map) {

		return sqlSessionTemplate.selectList("authorityCodeSearchList",map);
	}

	@Override
	@Transactional
	public int authorityCodeSearchlistsave(Map<String, Object> map) throws Exception {
		
		return sqlSessionTemplate.insert("authorityCodeListsave_insert", map);
		
	}
	
	@Override
	public int authorityCodeSearchlistdelete(Map<String, Object> map) throws Exception {
		

		return sqlSessionTemplate.delete("authorityCodeListsave_delete", map);
	}
	

	@Override
	public List<Map<String, Object>> authoritymappinglist(Map<String, Object> map) throws Exception {
		
		return sqlSessionTemplate.selectList("authoritymappinglist",map);

	}

	@Override
	public int authorityCodemainsave(Map<String, Object> map) throws Exception {

		return sqlSessionTemplate.insert("authorityCodemain_insert", map);
		
	}

}
