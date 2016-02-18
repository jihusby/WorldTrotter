
import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        print("Loading webView")
        let url = NSURL(string: "https://github.com")!
        webView.loadRequest(NSURLRequest(URL: url))
        webView.allowsBackForwardNavigationGestures = true
        view = webView
        
    }

}



