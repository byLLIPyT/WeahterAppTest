//
//  addCity.swift
//  WeatherAppTest
//
//  Created by Александр Уткин on 05.08.2021.
//

import UIKit

extension UIViewController {
    
    func alertPlusCity(name: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        
        let alert = UIAlertController(title: name, message: "Add city?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            let textAlert = alert.textFields?.first
            guard let text = textAlert?.text else { return }
            completionHandler(text)
        }
        
        alert.addTextField { (textFiled) in
            textFiled.placeholder = placeholder
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .default) { (_) in}
        alert.addAction(okAction)
        alert.addAction(alertCancel)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(nameCity: String, success result: Bool) {
        var message = ""
        if result {
            message = "City '\(nameCity)' added"
        } else {
            message = "City '\(nameCity)' not found"
        }
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertOk)
        present(alertController, animated: true, completion: nil)
        
    }
}
