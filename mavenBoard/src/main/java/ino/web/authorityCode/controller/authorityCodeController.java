package ino.web.authorityCode.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.javassist.expr.NewArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ino.web.authorityCode.service.authorityCodeService;
import ino.web.commonCode.service.CommCodeService;
import net.sf.json.JSONArray;

@Controller
@Transactional
public class authorityCodeController {

	@Autowired
	private authorityCodeService authorityCodeService;

	@Autowired
	PlatformTransactionManager transactionManager;

	// 처음화면
	@RequestMapping("/authorityCode.ino")
	public ModelAndView authorityCodelist() throws Exception {

		ModelAndView mav = new ModelAndView();

		Map<String, Object> map = new HashMap<String, Object>();

		List<HashMap<String, Object>> grouplist = authorityCodeService.authorityCodeList();

		map.put("num", grouplist.size());

		map.put("grouplist", grouplist);

		mav.addObject("map", map);

		mav.setViewName("authorityCodeMain");

		return mav;
	}
	

	
	//공지사항 이동
		@RequestMapping("/OBJ111.ino")
		public ModelAndView notice() throws Exception{

					ModelAndView mav = new ModelAndView();
					 
					mav.setViewName("notice");

				return mav;

			}
	
	//이벤트 이동
			@RequestMapping("/OBJ112.ino")
			public ModelAndView event() throws Exception{

						ModelAndView mav = new ModelAndView();
						 
						mav.setViewName("event");

					return mav;

				}

	//Q&A이동
	@RequestMapping("/OBJ120.ino")
	public ModelAndView QA() throws Exception{

				ModelAndView mav = new ModelAndView();
				 
				mav.setViewName("questionAndAnswer");
			
			return mav;

		}
	
	

	// 검색
	@Transactional
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/authorityCodeSearch.ino", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Map<String, Object> authorityCodeSearchlist(@RequestParam(value = "groupid") String groupid)
			throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();

		// VIEW로 자료를 전송할 data
		Map<String, Object> data = new HashMap<String, Object>();

		map.put("groupid", groupid);

		// 매핑테이블에 있는 값과 객체 테이블에 있는 값을 꺼내서 서로 비교후 중복되는 것들은 없애고, 매핑테이블에 있는 값들이 위로
		// 정렬되게 수정
		List<Map<String, Object>> searchlist = authorityCodeService.authorityCodeSearchlist(map); // 객체테이블

		data.put("searchlist", searchlist);

		System.out.println("data" + data);

		return data;
	}

	// 저장버튼을 눌렀을때
	@Transactional
	@RequestMapping(value = "/authorityCodeSearchlistsave.ino", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Map<String, Object> authorityCodeSearchlistsave(@RequestBody String paramData) throws Exception {

		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());

		// db랑 연결해서 자료를 전송할 map
		Map<String, Object> map = new HashMap<String, Object>();

		// VIEW로 자료를 전송할 data
		Map<String, Object> data = new HashMap<String, Object>();

		// 데이터 저장 map, view에서 가져온 데이터 저장
		List<Map<String, Object>> resultMap = new ArrayList<Map<String, Object>>();

		String message = "수정작업완료"; // view로 보낼 메시지, 정상적으로 자료가 들어가면 이 메시지가 출력됨

		resultMap = JSONArray.fromObject(paramData);

		map.put("groupid", resultMap.get(0).get("groupid"));

		// 매핑테이블에 있는 값을 가져올 map
		List<Map<String, Object>> mappingMap = new ArrayList<Map<String, Object>>();

		// 매핑테이블에 있는 오브젝트 아이디 저장할 배열
		String m_objectid[] = new String[resultMap.size()];

		// 그룹아이디에 맞는 매핑테이블을 가져온
		mappingMap = authorityCodeService.authoritymappinglist(map);

		// 매핑테이블에 있는 오브젝트 아이디 저장할 배열
		for (int m = 0; m < mappingMap.size(); m++) {

			m_objectid[m] = mappingMap.get(m).get("OBJECTID").toString();
		}

		// view에서 가져온 삭제할 오브젝트아이디를 저장할 배열
		String deletearr[] = new String[resultMap.size()];

		// view에서 가져온 checkid를 저장
		// 체크 되어있는건 아이디로 넘어오고, 안되어있는건 n으로 넘어옴
		for (int m = 0; m < resultMap.size(); m++) {

			deletearr[m] = resultMap.get(m).get("checkid").toString();
		}

		int insert_main = 0; // main이 insert되면 1증가

		// 일괄 insert시 main이 저장되어 있지 않다면 먼저 메인부터 저장함.
		// main은 high_obj가 null이므로 null일때 main을 먼저 insert시킨다.

		// 매핑테이블에서 가져온 값들을 저장(checkid와 비교)
		ArrayList<String> m_objectid_checkid = new ArrayList<>(Arrays.asList(m_objectid));

		// 반복문으로 view에서 가져온 아이디값과 중복되는 매핑테이블에서 가져온 아이디값을 비교해서 중복되는 값을 제거
		for (int j = 0; j < deletearr.length; j++) {

			m_objectid_checkid.remove(deletearr[j]);
		}

		// 메인을 제외한 나머지 insert 변수
		int insert_success = 0;

		try {

			for (int i = 0; i < resultMap.size(); i++) {

				String checkid = deletearr[i];

				// 체크한 아이디가 매핑테이블안에 있는지 판단하는 변수
				// 체크한 아이디가 매핑테이블에 있으면 true로 리턴
				boolean id = Arrays.asList(m_objectid).contains(checkid);

				String groupid = resultMap.get(i).get("groupid").toString();

				map.put("groupid", groupid);

				map.put("checkid", checkid);

				// view에서 넘어온 아이디 값이 있고, 매핑테이블에 저장되어 있지 않을 경우에 실행되는 삽입구문
				if (checkid != null) {

					if (!(checkid.equals("n")) && id == false) {

						if (resultMap.get(i).get("objectnm").toString() != null) {

							String objectnm = resultMap.get(i).get("objectnm").toString();

							String high_obj = resultMap.get(i).get("high_obj").toString();

							String dept = resultMap.get(i).get("dept").toString();

							map.put("objectnm", objectnm);

							map.put("high_obj", high_obj);

							map.put("dept", dept);

						}

						// 자료가 한개라도 insert가 되지 않으면 롤백을 시켜야 하지만, 에러가 발생하지 않아 강제로
						// 에러를 넣어서
						// 롤백처리시킴

						insert_success = authorityCodeService.authorityCodeSearchlistsave(map);

						if (insert_success == 0) {
							// 에러를 만들기위한 변수, insert가 한번이라도 안되면 롤백을 시켜야하기때문에
							// 에러를 발생시킨다.

							message = "상위객체가 저장되어있지 않습니다.";

							String err = null;
							String b = err.toString();

							break;
						}
					}

				}
			}

			// insert가 한번이라도 되지 않으면 실행되는 구문.

			// 삭제여부를 판단할 변수
			int delete = 0;

			// 삭제시 실행되는 구문
			// 삭제할 아이디가 담겨있는 배열에 값이 들어있을때만 실행
			// 한개라도 삭제가 안된 데이터가 있다면 롤백시켜야 하기 때문에 예외처리를 해준다.
			// 삭제할때는 체크해제한 오브젝트 아이디가 매핑테이블에 있는 오브젝트 아이디의 high_obj일때는 삭제를 못하도록
			// 해야한다.

			for (int i = m_objectid_checkid.size() - 1; i >= 0; i--) {

				if (m_objectid_checkid.get(i) != null) {

					String deleteid = m_objectid_checkid.get(i);

					map.put("uncheckid", deleteid);

					String groupid = resultMap.get(i).get("groupid").toString();

					map.put("groupid", groupid);

					delete = authorityCodeService.authorityCodeSearchlistdelete(map);

					if (delete == 0) {

						// 에러를 만들기위한 변수, delete가 한번이라도 안되면 롤백을 시켜야하기때문에
						// 에러를 발생시킨다.
						message = "하위객체를 먼저 삭제해야합니다.";
						String err = null;
						String b = err.toString();

					}

				}
			}

		} catch (NullPointerException e) {

			this.transactionManager.rollback(status);

		}

		if (message.equals("수정작업완료")) {

			this.transactionManager.commit(status);

		}

		// 매핑테이블에 이미 있는 값은 들어가지 않도록 값을 비교해서 매핑테이블에 없는 값만 집어넣음
		// db처리후에 다시 리스트를 가져옴
		List<Map<String, Object>> searchlist = authorityCodeService.authorityCodeSearchlist(map);

		data.put("searchlist", searchlist);

		data.put("message", message);

		return data;

	}

}
