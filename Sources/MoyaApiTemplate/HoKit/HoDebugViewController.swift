//
//  DebugViewController.swift
//  EastApi
//
//  Created by Hoa on 2020/5/15.
//  Copyright © 2020 HOA. All rights reserved.
//

import UIKit

public class HoDebugViewController: UIViewController {

    static func rootVC(_ message: Data?, header: [String: Any]?, requestParams: [String: Any]?, requestUrl: String?, method: String?, title: String?) -> UINavigationController {
        let vc = HoDebugViewController()
        vc.jsonData = message
        vc.header = header
        vc.requestParams = requestParams
        vc.requestUrl = requestUrl
        vc.method = method
        vc.title = title
        return UINavigationController(rootViewController: vc)
    }
    
    var message: String?
    var header: [String: Any]?
    var requestParams: [String: Any]?
    var requestUrl: String?
    var method: String?
    public var jsonData: Data!
    private var jsonString: String! {
        get {
            if let data = jsonData, let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                if let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) {
                    let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8)
                    return prettyPrintedJson
                }
            }
            return nil
        }
    }
    
    private var textView: UITextView!
    
    private var webView: UIWebView!
    
    private var requestParamsString: String! {
        
        if let prettyJsonData = try? JSONSerialization.data(withJSONObject: requestParams ?? [:], options: .prettyPrinted) {
            let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8)
            return prettyPrintedJson
        }
        
        return nil
    }
    
    private var requestHeaderString: String! {
        
        if let prettyJsonData = try? JSONSerialization.data(withJSONObject: header ?? [:], options: .prettyPrinted) {
            let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8)
            return prettyPrintedJson
        }
        
        return nil
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
    }
    
    
    func setupUI()  {
        
        var leftItem: UIBarButtonItem!
        if #available(iOS 13.0, *) {
            leftItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))
        } else {
            leftItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
        }
        leftItem.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftItem
        
        let commitItem = UIBarButtonItem(title: "复制全部", style: .plain, target: self, action: #selector(commit))
        commitItem.tintColor = .red
        
        let responseItem = UIBarButtonItem(title: "Copy Resp", style: .plain, target: self, action: #selector(copyResponse))
        responseItem.tintColor = .black
        
        self.navigationItem.rightBarButtonItems = [commitItem, responseItem]
        
        textView = UITextView(frame: view.bounds)
        textView.textColor = .black
        textView.font = UIFont.preferredFont(forTextStyle: .caption2)
        view.addSubview(textView)
        textView.isEditable = false
    }
    
    func updateUI() {
        
        textView.text = "BEBUGINFO: \n\n"
        textView.text += "请求链接: \(requestUrl ?? "")\n\n"
        textView.text += "请求方法: \(method ?? "")\n\n"
        textView.text += "请求头: \n\(requestHeaderString ?? "无") \n\n"
        textView.text += "请求数据: \n\(requestParamsString ?? "无") \n\n"
        textView.text += "响应数据: \n\n\(jsonString ?? "")"
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }

    @objc func commit() {
        UIPasteboard.general.string = textView.text
        presentAlert()
    }
    
    @objc func copyResponse() {
        UIPasteboard.general.string = jsonString
        presentAlert()
    }
    
    func presentAlert() {
        let alertVC = UIAlertController(title: "已复制", message: nil, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: "去粘贴", style: .cancel, handler: { _ in
            UIApplication.shared.open(URL.init(string: "weixin://")!, options: [ : ], completionHandler: nil)
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
}
