//
//  PolicyViewController.swift
//  playpart
//
//  Created by talha on 18/10/2021.
//

import UIKit
import WebKit
import SafariServices


class PolicyViewController: UIViewController , WKUIDelegate , WKNavigationDelegate , UIImagePickerControllerDelegate,UINavigationControllerDelegate,StoryboardInitializable{
    
    @IBAction func backBtnAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var url = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil);
        
        print("The url is here",self.url)
        self.loadWebRequest(url: url)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("View Load completely")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        self.webView.reload()
    }
    
    @IBAction func backAction(_ sender: Any) {
        if(self.webView.canGoBack) {
            self.webView.goBack()
        }
    }
    
    @IBAction func forwardAction(_ sender: Any) {
        if self.webView.canGoForward{
            self.webView.goForward()
        }
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
        print("WebVC DeInIt")
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        print(message)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            
            self.progressView.alpha = 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            
            if (self.webView.estimatedProgress >= 1){
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }) { (completed) in
                    self.progressView.progress = 0
                }
            }
        }
    }
    
    
    @objc func logoutFunCall (notification : NSNotification){
        
        print("The Observing The Value now Priting")
        
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            ///   webView.load(navigationAction.request)
        }
        
        return nil
    }
    
    
    
}


extension PolicyViewController  {
    
    static var storyboardName: UIStoryboard.Storyboard{ return .home}
}


//Custom Functions
extension PolicyViewController {
    
    func currentViewLogin(action : String , completeUrl : String){
        print(completeUrl)
    }
}




extension PolicyViewController  {
    
    
    @objc func reloadWebView(){
        
    }
    
    func loadWebRequest(url : String){
        
        let myURL = URL(string:url)
        let myRequest = URLRequest(url: myURL!)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.load(myRequest)
        
    }
    
    
}
