//
//  NavMenuController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 18..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import Foundation

struct NavMenuController{
    func webRedirect(segue : UIStoryboardSegue){
        if segue.identifier == "동아리"{
            if let destinationVC = segue.destination as? WebInfoViewController {
                destinationVC.setWebInfo(barTitle: "동아리 정보", url: "http://www.kau.ac.kr/onestopservice/soss_student_group_aero.html")
            }
        }else if segue.identifier == "화전역 열차 시간표"{
            if let destinationVC = segue.destination as? WebInfoViewController {
                destinationVC.setWebInfo(barTitle: "화전역 열차 시간표", url: "https://m.search.naver.com/search.naver?query=%ED%99%94%EC%A0%84%EC%97%AD&where=m&sm=mtp_hty")
            }
        }else if segue.identifier == "도서관 도서 검색"{
            if let destinationVC = segue.destination as? WebInfoViewController {
                destinationVC.setWebInfo(barTitle: "도서관 도서 검색", url: "http://lib.kau.ac.kr/HAULMS/SlimaDL.csp?HLOC=HAULMS&COUNT=2kij25cp00&Kor=1&frmDLL=frmDLL.csp?Left=Left02&frmDLR=Search/SearchC.csp?Gate=DA")
            }
        }else if segue.identifier == "스터디룸 예약현황"{
            if let destinationVC = segue.destination as? WebInfoViewController {
                destinationVC.setWebInfo(barTitle: "스터디룸 예약현황", url: "http://lib.kau.ac.kr/haulms/haulms/SRResv.csp")
            }
        }else if segue.identifier == "교직원 정보"{
            
            if let destinationVC = segue.destination as? WebInfoViewController {
                destinationVC.setWebInfo(barTitle: "교직원 정보", url: "http://www.kau.ac.kr/page/faculty/staff.jsp")
            }
            
        }else if segue.identifier == "시험 시간표"{
            if let destinationVC = segue.destination as? AccessWebViewController {
                //destinationVC.setChildInfo(stringURL2: "https://portal.kau.ac.kr/sugang/SugangExamList.jsp", stringTitle: "시험 시간표")
                destinationVC.stringURL = "https://portal.kau.ac.kr/sugang/SugangExamList.jsp"
                destinationVC.title = "시험 시간표"
            }
        }else if  segue.identifier == "성적 확인" {
            if let destinationVC = segue.destination as? AccessWebViewController {
               //destinationVC.setChildInfo(stringURL2: "https://portal.kau.ac.kr/sugang/GradTermList.jsp", stringTitle: "성적 확인")
                destinationVC.stringURL = "https://portal.kau.ac.kr/sugang/GradTermList.jsp"
                destinationVC.title = "성적 확인"
            }
        }else if segue.identifier == "장학금 수혜내역" {
            if let destinationVC = segue.destination as? AccessWebViewController {
                //destinationVC.setChildInfo(stringURL2: "https://portal.kau.ac.kr/sugang/PersScholarTakeList.jsp", stringTitle: "장학금 수혜내역")
                destinationVC.stringURL = "https://portal.kau.ac.kr/sugang/PersScholarTakeList.jsp"
                destinationVC.title = "장학금 수혜내역"
            }
            
        }
        
    }
    
}
