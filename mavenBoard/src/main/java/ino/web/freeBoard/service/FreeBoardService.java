package ino.web.freeBoard.service;

import java.util.List;
import java.util.Map;

public interface FreeBoardService {
	
public List<Object> freeBoardList(Map<String, Object> map) throws Exception;
			
public int freeBoardCount(Map<String, Object> map) throws Exception;
			
public Map<String, Object> freeBoardInsertPro(Map<String, Object> map) throws Exception;
	
public List<Object> getDetailByNum(int num) throws Exception;
	
public int getNewNum() throws Exception;
	
public void freeBoardModify(Map<String, Object> map) throws Exception;

public void FreeBoardDelete (int num) throws Exception;
	

}
