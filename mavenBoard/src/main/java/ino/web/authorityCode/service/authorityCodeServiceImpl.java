package ino.web.authorityCode.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.fasterxml.jackson.annotation.JacksonInject;

import ino.web.authorityCode.dao.authorityCodeDAO;


@Service
@Transactional
public class authorityCodeServiceImpl implements authorityCodeService {
	
	@Autowired
	authorityCodeDAO authoritycodedao;
	
	//트랜잭션 처리
	@Autowired
    PlatformTransactionManager transactionManager;



	@Override
	public List<HashMap<String, Object>> authorityCodeList() throws Exception {
		
		return authoritycodedao.authorityCodeList();
	}

	
	public List<Map<String, Object>> authorityCodeSearchlist(Map<String, Object> map) throws Exception{
		
		return authoritycodedao.authorityCodeSearchlist(map);
	}


	@Override
	public int authorityCodeSearchlistsave(Map<String, Object> map) throws Exception {

		return authoritycodedao.authorityCodeSearchlistsave(map);
	}

	@Override
	public int authorityCodeSearchlistdelete(Map<String, Object> map) throws Exception {
		
		return authoritycodedao.authorityCodeSearchlistdelete(map);
		
	}


	@Override
	public List<Map<String, Object>> authoritymappinglist(Map<String, Object> map) throws Exception {
		
		return authoritycodedao.authoritymappinglist(map);
	}


	@Override
	public int authorityCodemainsave(Map<String, Object> map) throws Exception {
		
		return authoritycodedao.authorityCodemainsave(map);
	}

}
