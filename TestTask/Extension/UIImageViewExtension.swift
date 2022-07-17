//
//  UIImageViewExtension.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 16.07.2022.
//

import Alamofire
import UIKit

extension UIImageView {
    func imageFromUrl(url: String) {
        guard !url.isEmpty else {
            self.image = Constants.defaultImage
            return
        }
        let request = AF.request(url)
        request.responseData { [weak self] result in
            DispatchQueue.main.async {
                guard let data = result.data else {
                    self?.image = Constants.defaultImage
                    return
                }
                self?.image = UIImage(data: data)
            }
        }
    }
}
