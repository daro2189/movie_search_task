//
//  ActivityVC.swift
//  GithubRepoSearcher
//
//  Created by Dariusz Mazur on 25/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import Foundation
import UIKit
import Async


class ActivityVC: UIViewController {
    fileprivate let activityView = ActivityView()
    
    init(message: String) {
        super.init(nibName: nil, bundle: nil)
        
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        
        activityView.messageLabel.text = message
        view = activityView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNewMessage(_ message: String) {
        activityView.setNewMessage(message)
    }
    
    class func showProgressDialog(_ message : String) -> ActivityVC {
        let alert = ActivityVC(message: message.localized)
        
        if let rootVC = UIApplication.shared.windows.first!.rootViewController {
            if rootVC.presentedViewController == nil {
                rootVC.present(alert, animated: true, completion: nil)
                return alert
            }
            
            if let _ = rootVC.presentedViewController as? ActivityVC {
                return alert
            }

            rootVC.presentedViewController!.present(alert, animated: true, completion: nil)
        }
        return alert
    }
    
    class func showProgressDialog(_ message : String, vc: UIViewController) -> ActivityVC {
        let alert = ActivityVC(message: message.localized)
        vc.present(alert, animated: true, completion: nil)
        return alert
    }

    
    class func getProgressDialog(_ message : String) -> ActivityVC {
        return ActivityVC(message: message.localized)
    }
    
    class func hideDialog(_ dialog : ActivityVC?) {
        if dialog == nil {
            return
        }
        
        Async.main {
            dialog?.dismiss(animated: true, completion: nil)
        }
    }
    
    class func hideDialog(_ dialog : ActivityVC?, completion: (() -> Void)?) {
        if dialog == nil {
            if completion != nil {
                Async.main {
                    completion!()
                }
            }
            return
        }
        
        Async.main {
            dialog?.dismiss(animated: true, completion: completion)
        }
    }
}

private class ActivityView: UIView {
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    let boundingBoxView = UIView(frame: CGRect.zero)
    let messageLabel = UILabel(frame: CGRect.zero)
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        
        boundingBoxView.backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        boundingBoxView.layer.cornerRadius = 12.0
        
        activityIndicatorView.startAnimating()
        activityIndicatorView.color = UIColor.white
        activityIndicatorView.hidesWhenStopped = true
        
        messageLabel.textColor = UIColor.white
        messageLabel.textAlignment = .center
        messageLabel.shadowColor = UIColor.black
        messageLabel.shadowOffset = CGSize(width: 0.0, height: 1.0)
        messageLabel.numberOfLines = 0
        
        addSubview(boundingBoxView)
        addSubview(activityIndicatorView)
        addSubview(messageLabel)
    }
    
    func setNewMessage(_ message: String) {
        messageLabel.text = message.localized
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        boundingBoxView.frame.size.width = 160.0
        boundingBoxView.frame.size.height = 140.0
        
        boundingBoxView.frame.origin.x = ceil((bounds.width / 2.0) - (boundingBoxView.frame.width / 2.0))
        boundingBoxView.frame.origin.y = ceil((bounds.height / 2.0) - (boundingBoxView.frame.height / 2.0))
        
        activityIndicatorView.frame.origin.x = ceil((bounds.width / 2.0) - (activityIndicatorView.frame.width / 2.0))
        activityIndicatorView.frame.origin.y = ceil((bounds.height / 2.0) - (activityIndicatorView.frame.height / 2.0))
        
        let messageLabelSize = messageLabel.sizeThatFits(CGSize(width: 200.0 - 20.0 * 2.0, height: CGFloat.greatestFiniteMagnitude))
        messageLabel.frame.size.width = messageLabelSize.width
        messageLabel.frame.size.height = messageLabelSize.height
        messageLabel.frame.origin.x = ceil((bounds.width / 2.0) - (messageLabel.frame.width / 2.0))
        messageLabel.frame.origin.y = ceil(activityIndicatorView.frame.origin.y + activityIndicatorView.frame.size.height + ((boundingBoxView.frame.height - activityIndicatorView.frame.height) / 4.0) - (messageLabel.frame.height / 2.0))
    }
}
