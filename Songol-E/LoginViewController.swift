//
//  LoginViewController.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 9. 5..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var labelID: UITextField!
    
    @IBOutlet weak var labelPW: UITextField!
    
    @IBAction func guestButtonOnClick(_ sender: Any) {
        performSegue(withIdentifier: "selectMajor", sender: nil)
    }
    
    var userID:String?
    var userPW:String?
    
    @IBAction func LoginButtonOnClick(_ sender: Any) {
        check = 0
        if labelID.text == nil || labelPW.text == nil{
            let alertController = UIAlertController(title: "로그인 실패",message: "ID/PW 를 모두 입력하십시오.", preferredStyle: UIAlertControllerStyle.alert)
            
            //UIAlertActionStye.destructive 지정 글꼴 색상 변경
            let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive){ (action: UIAlertAction) in
            }
            
            alertController.addAction(okAction)
            
            self.present(alertController,animated: true,completion: nil)
        }else{
            userID = labelID.text
            userPW = labelPW.text
            
            let url = URL(string: stringURL)
            webView.loadRequest(URLRequest(url: url!))
            webView.scalesPageToFit = true
        }
    }
    
    var check:Int = 0
    
    let stringURL :String = "https://www.kau.ac.kr/page/login.jsp?target_page=main.jsp&refer_page="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func initView(){
        labelID.placeholder = "Portal ID"
        labelPW.placeholder = "Portal PW"
    }
    
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        print(request.url)
        
        if check == 1 {
            check = 2
            if request.url?.absoluteString == "https://www.kau.ac.kr/page/act_login.jsp"{
                webView.loadRequest(URLRequest(url: URL(string: stringURL)!))
            }
        }
        
        return true
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView){
        
        if check == 2{
            check = 3
            
            if webView.request?.url?.absoluteString == stringURL{
                print("failed!!")
                
                let alertController = UIAlertController(title: "포털 사이트 로그인에 실패하였습니다.",message: "ID/PW 확인 후 재로그인 하십시오.", preferredStyle: UIAlertControllerStyle.alert)
                
                //UIAlertActionStye.destructive 지정 글꼴 색상 변경
                let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.destructive){ (action: UIAlertAction) in
                }
                
                alertController.addAction(okAction)
                
                self.present(alertController,animated: true,completion: nil)
                
            }else{
                print("done!!")
            }
        }
        
        if  check==0{

            let loadUsernameJS = "document.getElementsByName('p_id')[0].value = \'\(userID!)\';"

            let loadPasswordJS = "document.getElementsByName('p_pwd')[0].value = \'\(userPW!)\';"
            
            let onClickEventJS =  "var cells = document.getElementsByTagName('img');" + "for(var i=0; i < cells.length; i++){ var status = cells[i].getAttribute('alt');if(status=='로그인버튼'){ cells[i].click(); break;} }"
            
            self.webView.stringByEvaluatingJavaScript(from: loadUsernameJS)
            self.webView.stringByEvaluatingJavaScript(from: loadPasswordJS)
            self.webView.stringByEvaluatingJavaScript(from: onClickEventJS)
            
            check = 1
        }
    
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
