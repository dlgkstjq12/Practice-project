package ino.web.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import ino.web.authorityCode.service.authorityCodeService;
import ino.web.member.service.memberService;

@Controller
public class memberController {
	
	@Autowired
	private memberService memberService;
	
			//로그인페이지로 이동함
			@RequestMapping("/memberloginpage.ino")
			public ModelAndView memberloginpage() throws Exception {
				
				ModelAndView mav = new ModelAndView();

					mav.setViewName("login");
				
					return mav;
				}
				

		//로그인을 누르면 실행
		@RequestMapping("/memberlogin.ino")
		public ModelAndView memberlogin_id(String user_id, String member_pass, HttpSession session) throws Exception {

			System.out.println("로그인실행");
			
			ModelAndView mav = new ModelAndView();

			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("user_id", user_id);
			
			map.put("member_pass", member_pass);
						
			boolean result = memberService.loginCheck(map);	//로그인체크, 아이디와 비밀번호가 일치하면 아이디를 리턴시킨다.
			
			String message = null;
						
			//로그인 체크변수가 true이면 map에 있는 값을 세션에 담아서 view로 보낸다.
			if(result == true){
			
				session.setAttribute("user_id", map.get("user_id"));
								
				String id_groupid = memberService.id_authoritylist(map);	//로그인이 되었을 경우 유저아이디를 사용해서 그룹아이디를 가져옴
				
				map.put("groupid", id_groupid); //map에 groupid를 저장
			
				List<Map<String, Object>> id_authoritylist = memberService.id_list(map);
				
				System.out.println("id_authoritylist"+id_authoritylist);
				
				session.setAttribute("id_authoritylist", id_authoritylist);
												
				mav.setViewName("redirect:/");
				
			}else if(result == false){
				
				mav.setViewName("login");
				
				message = "회원가입된 회원의 아이디 혹은 비밀번호가 일치하지 않습니다.";
				 
				mav.addObject("message",message); 
				
			}
			
			return mav;
		}
			
				//로그아웃버튼을 누르면 실행
				@RequestMapping("/memberlogout.ino")
				public ModelAndView memberlogout(HttpSession session) throws Exception {

					session.invalidate();
					
					ModelAndView mav = new ModelAndView();
					
					mav.setViewName("redirect:/main.ino");
					
					return mav;
				}
		
		
		
	
}
