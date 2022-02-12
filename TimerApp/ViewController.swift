//
//  ViewController.swift
//  TimerApp
//
//  Created by Duxxless on 12.02.2022.
//

import UIKit

class ViewController: UIViewController {

    let nameAppLabel: UILabel = {
        let label = UILabel()
        label.text = "Timer"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .black
        
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.boldSystemFont(ofSize: 80)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let shapeView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0.1
        imageView.layer.shadowRadius = 1
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 1
        let image = UIImage(named: "ellipse")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        
        return layer
    }()
    
    let startButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = .darkText
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(nameAppLabel)
        view.addSubview(timerLabel)
        view.addSubview(shapeView)
        view.addSubview(startButton)
        
    }

    override func viewDidLayoutSubviews() {
        NSLayoutConstraint.activate([
            nameAppLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            nameAppLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            shapeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shapeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            shapeView.widthAnchor.constraint(equalToConstant: 300),
            shapeView.heightAnchor.constraint(equalToConstant: 300),
            
            shapeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shapeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            shapeView.widthAnchor.constraint(equalToConstant: 300),
            shapeView.heightAnchor.constraint(equalToConstant: 300),
            
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 170),
            startButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

