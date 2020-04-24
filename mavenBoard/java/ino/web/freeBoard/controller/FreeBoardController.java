package ino.web.freeBoard.controller;


import ino.web.commonCode.service.CommCodeService;
import ino.web.freeBoard.common.util.Pager;
import ino.web.freeBoard.service.FreeBoardService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Date;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.Service;

import org.apache.tiles.request.Request;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


	@Controller
	public class FreeBoardController {
		
		

		
	private static final RequestMethod[] POST = null;
		
	
	@Autowired
	private FreeBoardService freeBoardService;
	
	@Autowired
	private CommCodeService commCodeService;
	
	
	/*@RequestMapping(value = "/main.ino", method = RequestMethod.POST)
	@ResponseBody*/
	
	
	
	
	@RequestMapping("/main.ino")
	@ResponseBody
	public ModelAndView main(@RequestParam(defaultValue="", value="search_option") String search_option,
			@RequestParam(defaultValue="", value="keyword")String keyword,
			@RequestParam(defaultValue="", value="startDate") String startDate,
			@RequestParam(defaultValue="", value="endDate")String endDate,
			@RequestParam(defaultValue="", value="startDateFirst") String startDateFirst,
			@RequestParam(defaultValue="", value="endDateFirst")String endDateFirst,
			@RequestParam(defaultValue="1", value="curPage") int curPage) throws Exception{
				
		System.out.println("메인실행");
		
				Map<String, Object> map = new HashMap<String, Object>();
				
				
				map.put("code", "COM001");
				
				List<HashMap<String,Object>> listComon = commCodeService.selectCommonCodeList(map);
				
				
				
				System.out.println("listComon" +listComon);
				
				map.put("search_option", search_option);
		
				map.put("keyword", keyword);
				
				map.put("startDate", startDate);
					
				map.put("endDate", endDate);
				
				int count = freeBoardService.freeBoardCount(map);
				
				
				map.put("count", count);
				
				map.put("curPage", curPage);
				
				List<Object> list = freeBoardService.freeBoardList(map);
				
				
				map.put("search_option", search_option);	
				
				map.put("startDate", startDateFirst);	//하이픈 넣은 값을 보내기 위해 재설정
					
				map.put("endDate", endDateFirst);	//하이픈 넣은 값을 보내기 위해 재설정	
				
				map.put("startDateFirst", startDateFirst);	//하이픈 넣은 값을 보내기 위해 재설정
				
				map.put("endDateFirst", endDateFirst);	//하이픈 넣은 값을 보내기 위해 재설정
				
				map.put("list", list);
				
				map.put("listComon", listComon);
				
				
				
				ModelAndView mav = new ModelAndView();
				 
				mav.setViewName("boardMain");
				
				mav.addObject("map",map);
				
				
				System.out.println("map : " +map);
		
			
			return mav;

		}


	@RequestMapping("/search.result.ino")
	@ResponseBody
	public Map<String, Object> searchmain(HttpServletRequest request,
			@RequestParam (defaultValue="", value="search_option")String search_option,
			@RequestParam (defaultValue="", value="keyword")String keyword,
			@RequestParam(defaultValue="", value="startDate") String startDate,
			@RequestParam(defaultValue="", value="endDate")String endDate,
			@RequestParam(defaultValue="", value="startDateFirst") String startDateFirst,
			@RequestParam(defaultValue="", value="endDateFirst")String endDateFirst,
			@RequestParam(defaultValue="1", value="curPage") int curPage,
			String code) throws Exception{
		

		System.out.println("=========검색================");
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("code", "COM001");
		List<HashMap<String, Object>> listComon = commCodeService.selectCommonCodeList(map);
		
		
		/*List<HashMap<Object,Object>> listComon = commCodeService.selectCommonCodeList(map);*/
		
		map.put("search_option", search_option);
		
		map.put("keyword", keyword);
		
		map.put("startDate", startDate);
		
		map.put("endDate", endDate);
		
		
		//레코드 갯수를 계산
		int count = freeBoardService.freeBoardCount(map);
		
		map.put("count", count);
		
		map.put("curPage", curPage);
						
		
		//페이지 관련 설정, 시작번호와 끝번호를 구해서 각각 변수에 저장
				
				
		
		List<Object> list = freeBoardService.freeBoardList(map);
		
		map.put("startDate", startDateFirst);	//하이픈 넣은 값을 보내기 위해 재설정
		
		map.put("endDate", endDateFirst);	//하이픈 넣은 값을 보내기 위해 재설정
		
		
		map.put("startDateFirst", startDateFirst);	//하이픈 넣은 값을 보내기 위해 재설정
		
		map.put("endDateFirst", endDateFirst);	//하이픈 넣은 값을 보내기 위해 재설정
		
		
		map.put("list", list);
		
		/*map.put("listComon", listComon);*/
		
		
		System.out.println("map안에 들어있는 값 :"+map);
		
			
		System.out.println("list안에 들어있는 값 :"+list);
		
		return map;
		
	}
	
	
	@RequestMapping("/freeBoardInsert.ino")
	public String freeBoardInsert(){
		return "freeBoardInsert";
	}
	
	
	//글쓰기
	

	@RequestMapping(value = "/freeBoardInsertPro.ino", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> freeBoardInsertPro(HttpServletRequest request) throws Exception{
		
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String name = request.getParameter("name");
		
		String title = request.getParameter("title");
		
		String content = request.getParameter("content");
		
		
		map.put("name", name);
		
		map.put("title", title);
		
		map.put("content", content);
				
		freeBoardService.freeBoardInsertPro(map);
		
		return map;
			

	}
	
	
	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(@RequestParam int num,
			@RequestParam(defaultValue="", value = "search_option") String search_option,
			@RequestParam(defaultValue="", value = "keyword")String keyword,
			@RequestParam(defaultValue="", value="startDate") String startDate,
			@RequestParam(defaultValue="", value="endDate")String endDate,
			@RequestParam(defaultValue="", value="startDateFirst") String startDateFirst,
			@RequestParam(defaultValue="", value="endDateFirst")String endDateFirst,
			@RequestParam(defaultValue="1") int curPage) throws Exception{
		
		
		
		ModelAndView mav = new ModelAndView();
		
		Map<String,Object> map = new HashMap<>();
		
		map.put("search_option", search_option);
		
		map.put("keyword", keyword);
		
		List<Object> list  = freeBoardService.getDetailByNum(num);
		
		map.put("startDate", startDate);	//하이픈 넣은 값을 보내기 위해 재설정
		
		map.put("endDate", endDate);	//하이픈 넣은 값을 보내기 위해 재설정
		
		map.put("curPage", curPage);	//하이픈 넣은 값을 보내기 위해 재설정
		
		map.put("startDateFirst", startDateFirst);	//하이픈 넣은 값을 보내기 위해 재설정
		
		map.put("endDateFirst", endDateFirst);	//하이픈 넣은 값을 보내기 위해 재설정
	
		

		map.put("list", list);

		mav.setViewName("freeBoardDetail");
		
		mav.addObject("map",map);
		
		System.out.println("Map 안에 들어있는 값"+map);
		
		return mav;
	}
	
	

	
	@RequestMapping(value = "/freeBoardModify.ino", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> freeBoardModify(HttpServletResponse insert, HttpServletRequest request, 
			@RequestParam int num,
			@RequestParam String name, 
			@RequestParam String title,
			@RequestParam String content) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String decodename = URLDecoder.decode(name, "UTF-8");
			
		String decodetitle = URLDecoder.decode(title, "UTF-8");

		String decodecontent = URLDecoder.decode(content, "UTF-8");
		
		map.put("num", num);
		
		map.put("name", decodename);
		
		map.put("title", decodetitle);
		
		map.put("content", decodecontent);

		freeBoardService.freeBoardModify(map);

		return map;
		
		
	}
	
	@RequestMapping("/freeBoardDelete.ino")
	@ResponseBody
	
	public Map<String, Object> FreeBoardDelete(HttpServletResponse rs, @RequestParam int num)throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();

		System.out.println("num :"+num);
		
		freeBoardService.FreeBoardDelete(num);
		
		map.put("num", num);
	
		return map;
	}
}