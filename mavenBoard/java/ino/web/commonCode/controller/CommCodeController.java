package ino.web.commonCode.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ino.web.commonCode.service.CommCodeService;
import net.sf.json.JSONArray;

@Controller
public class CommCodeController {

	@Autowired
	private CommCodeService commCodeService;

	@RequestMapping("/commonCode.ino")
	public ModelAndView commonCode(HttpServletRequest req) {

		ModelAndView mav = new ModelAndView();
		
		Map<String, Object> map = new HashMap<String, Object>();

		List<HashMap<String, Object>> list = commCodeService.CommonCodeList();
		
		map.put("list", list);

		mav.addObject("map", map);

		mav.setViewName("commonCodeMain");

		return mav;
	}
	
	
	@RequestMapping("/commonCodeDetail.ino")
	public ModelAndView commonCodeDetail(String num) {
		
		ModelAndView mav = new ModelAndView();
		
		Map<String, Object> map = new HashMap<String, Object>();

		List<HashMap<String, Object>> list = commCodeService.CommonCodeDetail(num);
		
		map.put("list", list);
		
		map.put("num", num);
		
		System.out.println("공통코드 리스트 값:" +map);

		mav.addObject("map", map);

		mav.setViewName("commonCodeDetail");

		return mav;
		
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/commonCodeInsert.ino", method = {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public List<Map<String, Object>> commonCodeInsert(
		HttpServletRequest request, 
		@RequestBody String paramData) throws  Exception{
		


		System.out.println("insert 실행");
		
		
		//db랑 연결해서 자료를 전송할 map
		Map<String, Object> map = new HashMap<String, Object>();
		  
        System.out.println("=data=");
        
        
        //데이터 저장 map
        List<Map<String,Object>> resultMap = new ArrayList<Map<String,Object>>();
        
        resultMap =  JSONArray.fromObject(paramData);
        
        System.out.println("resultMap"+resultMap);
        
        int size = resultMap.size();
        
        System.out.println("size : "+size);
       
        System.out.println("=data=");
       
		
		for(int i = 0; i < resultMap.size(); i++){
			
			String num = resultMap.get(i).get("num").toString();
			
			String decode = resultMap.get(i).get("decode").toString();
			
			String decode_name = resultMap.get(i).get("decode_name").toString();
			
			String use_yn = resultMap.get(i).get("use_yn").toString();
			
			
			System.out.println("num:" +num);
			
			System.out.println("decode:" +decode);
			
			System.out.println("decode_name" +decode_name);
			
			System.out.println("use_yn:" +use_yn);
			
			map.put("num", num);
			
			map.put("decode", decode);
			
			map.put("decode_name", decode_name);
			
			map.put("use_yn", use_yn);
			
			commCodeService.commonCodeInsert(map);
			
			System.out.println("공통코드 delete 값:" +map);
		}
	
			
		System.out.println("공통코드 총 delete 값:" +resultMap);

		return resultMap;
		
	}
	
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/commonCodeDelete.ino", method = {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, Object>> commonCodeDelete(
		HttpServletRequest request, 
		@RequestBody String DeleteData) throws  Exception{
		
		
		String num = request.getParameter("num");
		

		System.out.println("Delete 실행");
		
		

		Map<String, Object> map = new HashMap<String, Object>();
		  
        System.out.println("=data=");
        
        
        //삭제할 데이터 저장할 map
        List<Map<String,Object>> DeleteMap = new ArrayList<Map<String,Object>>();

        DeleteMap =  JSONArray.fromObject(DeleteData);
        
        System.out.println("resultMap"+DeleteMap);
        
        int size = DeleteMap.size();
        
        System.out.println("size : "+size);
       
        System.out.println("=data=");
       
		
		for(int i = 0; i < DeleteMap.size(); i++){
			
			String decode = DeleteMap.get(i).get("decode").toString();
		
			System.out.println("decode" +decode);
			
			map.put("decode", decode);
			
			commCodeService.commonCodeDelete(map);
			
			System.out.println("공통코드 insert 값:" +map);
		}
		
		
		
		
		    Map<String, Object> resultMap = new HashMap<String, Object>();
	        	        
	        
	        List<HashMap<String, Object>> list = commCodeService.CommonCodeDetail(num);
			
	        
	        System.out.println("list안에 들어있는 값 : "+list);
	        
	        
	        resultMap.put("list", list);
			
	        resultMap.put("num", num);
		
		
		return list;
		
	}


}
