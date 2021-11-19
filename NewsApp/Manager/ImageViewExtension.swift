//
//  ImageViewExtension.swift
//  TestTestTestttettstst
//
//  Created by Владимир Тимофеев on 19.11.2021.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImageFrom(link: String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask(with: URL(string:link)!, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
