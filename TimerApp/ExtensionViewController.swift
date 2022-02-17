//
//  ExtensionViewController.swift
//  TimerApp
//
//  Created by Duxxless on 17.02.2022.
//

import UIKit


extension ViewController {
    
    func setAlert() {
        
        let alert = UIAlertController(title: "Время вышло!", message: nil, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "ОК", style: .cancel) { _ in
            print("Готово")
        }
        
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
}
