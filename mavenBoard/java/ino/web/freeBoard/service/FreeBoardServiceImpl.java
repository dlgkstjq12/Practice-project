package ino.web.freeBoard.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.annotation.JacksonInject;

import ino.web.freeBoard.common.util.Pager;
import ino.web.freeBoard.dao.FreeBoardDAO;

@Service
public class FreeBoardServiceImpl implements FreeBoardService {
	
	@Autowired
	FreeBoardDAO freeboarddao;
	
	@Override
	public List<Object> freeBoardList(Map<String, Object> map) throws Exception {
		
		int count = (int) map.get("count");
		
		System.out.println("count : "+count);
		
		
		
		int curPage = (int) map.get("curPage");
		
		System.out.println("curPage : "+curPage);
		
		
		
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		map.put("start", start);
		
		map.put("end", end);
		
		map.put("pager", pager);
		
		
		return freeboarddao.freeBoardList(map);
	}

	@Override
	public int freeBoardCount(Map<String, Object> map) throws Exception {
	
		return freeboarddao.freeBoardCount(map);
	}

	@Override
	public Map<String, Object> freeBoardInsertPro(Map<String, Object> map) throws Exception {
		
		
			
			System.out.println("insert문 에러");
			
			System.out.println("map"+map);
			
			int insertPro = freeboarddao.freeBoardInsertPro(map);
			
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

	@Override
	public List<Object> getDetailByNum(int num) throws Exception {
		
		return freeboarddao.getDetailByNum(num);
	}

	@Override
	public int getNewNum() throws Exception {
		
		return freeboarddao.getNewNum();
	}

	@Override
	public void freeBoardModify(Map<String, Object> map) throws Exception {
		
		
		try {
			
			boolean modifyResult = true;
			
			freeboarddao.freeBoardModify(map);
			
			map.put("modifyResult", modifyResult);
			
		} catch (Exception e) {
			
			boolean modifyResult = false;
			
			map.put("modifyResult", modifyResult);
			
		}
		
		
		
		
	}

	@Override
	public void FreeBoardDelete(int num) throws Exception {
		
		freeboarddao.FreeBoardDelete(num);
		
	}

}
