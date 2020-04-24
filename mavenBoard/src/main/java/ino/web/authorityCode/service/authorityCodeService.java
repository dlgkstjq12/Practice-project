package ino.web.authorityCode.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface authorityCodeService {
	
public List<HashMap<String, Object>> authorityCodeList() throws Exception;

public List<Map<String, Object>> authorityCodeSearchlist(Map<String, Object> map) throws Exception;

public int authorityCodeSearchlistsave (Map<String, Object> map) throws Exception;

public int authorityCodeSearchlistdelete(Map<String, Object> map) throws Exception;

public List<Map<String, Object>> authoritymappinglist (Map<String, Object> map) throws Exception;

public int authorityCodemainsave (Map<String, Object> map) throws Exception;

}
