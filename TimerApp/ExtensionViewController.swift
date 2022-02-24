//
//  ExtensionViewController.swift
//  TimerApp
//
//  Created by Duxxless on 17.02.2022.
//

import UIKit

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func setAlert() {
        
        let alert = UIAlertController(title: "Время вышло!", message: nil, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "ОК", style: .cancel) { _ in
            print("Готово")
        }
        
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return time.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let currentTime = String(time[row])
        return currentTime
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currentTime = String(time[row])
        timerLabel.text = currentTime
    }
}
