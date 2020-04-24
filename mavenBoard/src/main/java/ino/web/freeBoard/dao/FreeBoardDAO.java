package ino.web.freeBoard.dao;

import java.util.List;
import java.util.Map;

public interface FreeBoardDAO {

	public List<Object> freeBoardList(Map<String, Object> map) throws Exception;

	public int freeBoardCount(Map<String, Object> map) throws Exception;

	public int freeBoardInsertPro(Map<String, Object> map) throws Exception;

	public List<Object> getDetailByNum(int num) throws Exception;

	public int getNewNum() throws Exception;

	public void freeBoardModify(Map<String, Object> map) throws Exception;

	public void FreeBoardDelete(int num) throws Exception;

}
