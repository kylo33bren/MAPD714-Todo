//
//  Extensions.swift
//  ToDo
//
//  Created by Brendan Rodrigues on 2022-11-19.
//  Authors:Brendan Rodrigues 301119016, Vatsalkumar Patel 300874931
//  Todo app v 1.5
//
//  25/11/2022
//

import Foundation
import UIKit

extension Date{
    func toString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: self)
    }

}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}


extension String {
    func toDate() -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.date(from: self)!
    }
}



extension UIViewController {

    func showYesNoAlert (title: String?, message: String, completion:@escaping () -> Void) {
        let customAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { _ in
            completion()
        }
        let noAction = UIAlertAction(title: "No", style: UIAlertAction.Style.default) { _ in
            // Do Nothing
        }
        customAlert.view.tintColor = #colorLiteral(red: 0.09803921569, green: 0.6352941176, blue: 1, alpha: 1)
        
        customAlert.addAction(noAction)
        customAlert.addAction(yesAction)
        self.present(customAlert, animated: true, completion: nil)
    }
}
