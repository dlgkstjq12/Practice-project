package ino.web.freeBoard.dao;

import java.util.List;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import org.mybatis.spring.SqlSessionTemplate;

@Repository	//dao 관련 빈
public class FreeBoardDAOImpl implements FreeBoardDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List<Object> freeBoardList(Map<String, Object> map) throws Exception {
	
		return sqlSessionTemplate.selectList("freeBoardlist",map);
	}

	@Override
	public int freeBoardCount(Map<String, Object> map) throws Exception {
		
		return sqlSessionTemplate.selectOne("freeBoardCount",map);
	}

	@Override
	public int freeBoardInsertPro(Map<String, Object> map) throws Exception {
		
		return sqlSessionTemplate.insert("freeBoardInsertPro",map);
	}

	@Override
	public List<Object> getDetailByNum(int num) throws Exception {
		
		return sqlSessionTemplate.selectList("freeBoardDetailByNum", num);
	}

	@Override
	public int getNewNum() throws Exception {
		
		return sqlSessionTemplate.selectOne("freeBoardNewNum");
	}

	@Override
	public void freeBoardModify(Map<String, Object> map) throws Exception {
		
		sqlSessionTemplate.update("freeBoardModify", map);

	}

	@Override
	public void FreeBoardDelete(int num) throws Exception {
		
		sqlSessionTemplate.delete("freeBoardDelete", num);

	}

}
