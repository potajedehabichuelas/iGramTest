//
//  IGLoginViewController.swift
//  iGram
//
//  Created by Daniel Bolivar herrera on 2/10/17.
//  Copyright © 2017 iGenius. All rights reserved.
//

import UIKit

class IGLoginViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var loginWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginWebView.scrollView.isScrollEnabled = false;
        

        if IGSettings.sharedInstance.token != "" {
            self.authenticationSuccess()
        } else {
            guard let loginUrl = IGNetworkManager.sharedInstance.getInstagramLoginUrl() else { return }
            self.loginWebView.loadRequest(URLRequest(url: loginUrl))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeRootViewController(with identifier:String!) {
        
        let storyboard = self.storyboard
        let desiredViewController = storyboard?.instantiateViewController(withIdentifier: identifier);
        
        let snapshot:UIView = (UIApplication.shared.delegate!.window!!.snapshotView(afterScreenUpdates: true))!
        desiredViewController?.view.addSubview(snapshot);
        
        UIApplication.shared.delegate?.window??.rootViewController = desiredViewController
        
        UIView.animate(withDuration: 0.3, animations: {() in
            snapshot.layer.opacity = 0;
            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        }, completion: {
            (value: Bool) in
            snapshot.removeFromSuperview();
        });
    }
    
    // MARK: UIWebViewDelegate functions
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let requestUrl = request.mainDocumentURL?.absoluteString, (requestUrl.range(of: InstagramURL.redirectToken) != nil) else { return true }
            
        if IGNetworkManager.sharedInstance.retrieveTokenFromRedirectUrl(urlString: requestUrl) {
            //Token has been successfully retrieved and saved - Everything OK
            self.authenticationSuccess();
        }
        
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        if let requestUrl = webView.request?.mainDocumentURL?.absoluteString, (requestUrl.range(of: InstagramURL.redirectToken) != nil) {
            if IGNetworkManager.sharedInstance.retrieveTokenFromRedirectUrl(urlString: requestUrl) {
                //Do not load and dismiss the VC
                webView.isHidden = true;
                self.authenticationSuccess();
            }
        }
    }
    
    func authenticationSuccess() {
        //Change Root VC to the photo gallery VC
        self.changeRootViewController(with: R.storyboard.main.igNavController.identifier)
    }
}
