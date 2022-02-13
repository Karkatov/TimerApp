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
        imageView.alpha = 1
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.3
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
    
    var timer = Timer()
    
    var durationTimer = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(nameAppLabel)
        view.addSubview(timerLabel)
        view.addSubview(shapeView)
        view.addSubview(startButton)
        setLayout()
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        timerLabel.text = "10"
        
    }

    override func viewDidLayoutSubviews() {
        self.animationCircular()
    }
}

extension ViewController {
    
    @objc func startButtonTapped() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        
        durationTimer -= 1
        timerLabel.text = "\(durationTimer)"
        if durationTimer == 0 {
            timer.invalidate()
            durationTimer = 10
            timerLabel.text = "10"
        }
    }
    
    // MARK: - Animation
    
    func animationCircular() {
        let center = CGPoint(x: shapeView.frame.width / 2, y: shapeView.frame.height / 2 )
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 138, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 35
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        shapeLayer.strokeColor = UIColor.systemGreen.cgColor
        shapeView.layer.addSublayer(shapeLayer)
    }
    
    func setLayout() {
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


