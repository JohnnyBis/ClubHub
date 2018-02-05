//
//  ImageCaching.swift
//  ClubHub
//
//  Created by Gianmaria Biselli on 1/28/18.
//  Copyright © 2018 Gianmaria Biselli. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

var imageURLString: String?

extension UIImageView {
    
    
    func downloadImageFrom(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url: url)
    }
    
    func downloadImageFrom(url: URL){
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: data){
                        imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                        self.image = imageToCache
                        
                    }
                }
            }.resume()
        }
    }
    
}

