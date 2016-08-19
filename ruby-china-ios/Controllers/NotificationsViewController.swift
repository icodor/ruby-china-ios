//
//  NotificationsViewController.swift
//  ruby-china-ios
//
//  Created by 柯磊 on 16/8/2.
//  Copyright © 2016年 ruby-china. All rights reserved.
//

import UIKit

class NotificationsViewController: WebViewController {
    var lastUnreadCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "trash"), style: .Plain, target: self, action: #selector(cleanNotificationsAction))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadVisitable()
        if let app = UIApplication.sharedApplication().delegate as? AppDelegate {
            app.refreshUnreadNotificationCount()
        }
    }
    
    func cleanNotificationsAction() {
        visitableView.webView?.evaluateJavaScript("$('#btn-remove-all').click();") { [weak self] (obj, err) in
            self?.visitableView.webView?.reload()
            
            if let app = UIApplication.sharedApplication().delegate as? AppDelegate {
                app.refreshUnreadNotificationCount()
            }
        }
    }
}
