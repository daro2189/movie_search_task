//
//  DialogUtils.swift
//  GithubRepoSearcher
//
//  Created by Dariusz Mazur on 25/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import UIKit


class DialogUtils {
    
    class func showOKDialog(_ title : String, message : String) {
        let alert = UIAlertController(title: title.localized, message: message.localized, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK".localized, style:.default, handler: { (action: UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(ok)
        
        if let rootVC = UIApplication.shared.windows.first!.rootViewController {
            if rootVC.presentedViewController == nil {
                rootVC.present(alert, animated: true, completion: nil)
                return
            }
            
            if let _ = rootVC.presentedViewController as? ActivityVC {
                return
            }

            rootVC.presentedViewController!.present(alert, animated: true, completion: nil)
        }
    }
}
