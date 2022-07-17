//
//  UIViewControllerExtension.swift
//  TestTask
//
//  Created by Хандымаа Чульдум on 17.07.2022.
//

import UIKit

extension UIViewController {
    func showOKAlert(withText text: String?, andTitle title: String? = "", tintColor: UIColor? = nil) {
        let alertView = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let okAct = UIAlertAction(title: "ОК", style: .default)
        if let tintColor = tintColor {
            okAct.setValue(tintColor, forKey: "titleTextColor")
        }
        alertView.addAction(okAct)
        self.present(alertView, animated: true, completion: nil)
    }
}
