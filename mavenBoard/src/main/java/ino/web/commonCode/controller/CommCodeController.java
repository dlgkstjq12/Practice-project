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

	@RequestMapping("/OBJ110.ino")
	public ModelAndView commonCode(HttpServletRequest req) {

		ModelAndView mav = new ModelAndView();
		
		Map<String, Object> map = new HashMap<String, Object>();

		List<HashMap<String, Object>> list = commCodeService.CommonCodeList();
		
		map.put("list", list);

		mav.addObject("map", map);
		
		mav.addObject("abbress", "OBJ110");

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
			
		//db랑 연결해서 자료를 전송할 map
		Map<String, Object> map = new HashMap<String, Object>();
        
        //데이터 저장 map
        List<Map<String,Object>> resultMap = new ArrayList<Map<String,Object>>();
        
        resultMap =  JSONArray.fromObject(paramData);
        
        System.out.println("resultMap"+resultMap);
        
        int size = resultMap.size();
		
		for(int i = 0; i < resultMap.size(); i++){
			
			String num = resultMap.get(i).get("num").toString();
			
			String decode = resultMap.get(i).get("decode").toString();
			
			String decode_name = resultMap.get(i).get("decode_name").toString();
			
			String use_yn = resultMap.get(i).get("use_yn").toString();
					
			map.put("num", num);
			
			map.put("decode", decode);
			
			map.put("decode_name", decode_name);
			
			map.put("use_yn", use_yn);
			
			commCodeService.commonCodeInsert(map);
			
		}

		return resultMap;
		
	}
	
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/commonCodeDelete.ino", method = {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public List<HashMap<String, Object>> commonCodeDelete(
		HttpServletRequest request, 
		@RequestBody String DeleteData) throws  Exception{
		
		
		String num = request.getParameter("num");
		
		Map<String, Object> map = new HashMap<String, Object>();
		  

        //삭제할 데이터 저장할 map
        List<Map<String,Object>> DeleteMap = new ArrayList<Map<String,Object>>();

        DeleteMap =  JSONArray.fromObject(DeleteData);
        
     
        
        int size = DeleteMap.size();
     
       
		
		for(int i = 0; i < DeleteMap.size(); i++){
			
			String decode = DeleteMap.get(i).get("decode").toString();
		
		
			
			map.put("decode", decode);
			
			commCodeService.commonCodeDelete(map);
			
		
		}
		
		
		
		
		    Map<String, Object> resultMap = new HashMap<String, Object>();
	        	        
	        
	        List<HashMap<String, Object>> list = commCodeService.CommonCodeDetail(num);
			
	        
	      
	        
	        
	        resultMap.put("list", list);
			
	        resultMap.put("num", num);
		
		
		return list;
		
	}


}
