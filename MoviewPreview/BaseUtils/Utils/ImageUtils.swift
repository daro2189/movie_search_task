//
//  ImageUtils.swift
//  MoviePreview
//
//  Created by Dariusz Mazur on 29/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import Foundation
import Kingfisher
import Async

class ImageUtils {
    
    class func getImage(urlImage: String, completitionHandler: @escaping (UIImage?) -> Void) {
        guard let url = URL.init(string: urlImage) else {
            return completitionHandler(nil)
        }
        
        let resource = ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                Async.main { () in
                    completitionHandler(value.image)
                }
            case .failure:
                Async.main { () in
                    completitionHandler(nil)
                }
            }
        }
    }
}
