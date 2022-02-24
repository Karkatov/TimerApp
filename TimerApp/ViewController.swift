//
//  ViewController.swift
//  TimerApp
//
//  Created by Duxxless on 12.02.2022.
//
import SnapKit
import UIKit
import Spring
import AudioToolbox

class ViewController: UIViewController {
    let secondView = UIView()
    let textField = UITextField()
    let nameAppLabel: UILabel = {
        let label = UILabel()
        label.text = "Timer"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .black
        
        label.textAlignment = .center
        
        return label
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.boldSystemFont(ofSize: 80)
        label.textColor = .black
        label.textAlignment = .center
        
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
        
        return imageView
    }()
    
    let time: [Int] = {
        var time = [Int]()
        for sec in 1...60 {
           time += [sec]
        }
        return time
    }()
    
    let hours: [Int] = {
        var time = [Int]()
        for sec in 0...23 {
           time += [sec]
        }
        return time
    }()
    
    let shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    
    let startButton: SpringButton = {
        let button = SpringButton(type: .custom)
        button.setTitle("START", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = .darkText
        button.layer.cornerRadius = 20
        
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
        setImageViewTapped()
    }
    
    override func viewDidLayoutSubviews() {
        self.animationCircular()
        startButton.animation = "fadeIn"
        startButton.delay = 0.3
        startButton.duration = 1
        startButton.animate()
    }
}

extension ViewController {
    
    @objc func startButtonTapped() {
        durationTimer = Int(timerLabel.text!)!
        guard durationTimer > 0 else { return }
        setBasicAnimation()
        self.animateButton()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        startButton.isEnabled = false
    }
    
    @objc func timerAction() {
        
        durationTimer = Int(timerLabel.text!)!
        durationTimer -= 1
        timerLabel.text = "\(durationTimer)"
        if durationTimer == 0 {
            self.setAlert()
            timer.invalidate()
            
            startButton.isEnabled = true
            
            self.startButton.isHidden = false
            startButton.animation = "squeezeUp"
            startButton.delay = 0.3
            startButton.duration = 1
            AudioServicesPlaySystemSound(1000)
            startButton.animate()
        }
    }
    
    // MARK: - Animation
    
    func animationCircular() {
        let center = CGPoint(x: shapeView.frame.width / 2, y: shapeView.frame.height / 2 )
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        
        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: 131,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.lineWidth = 23
        shapeLayer.fillColor = .none
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = .round
        shapeLayer.strokeColor = UIColor.systemGreen.cgColor
        shapeView.layer.addSublayer(shapeLayer)
    }
    
    func setBasicAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = CFTimeInterval(durationTimer)
        animation.toValue = 0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = true
        shapeLayer.add(animation, forKey: nil)
    }
    
    func setLayout() {
        
        nameAppLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.centerX.equalToSuperview()
        }
        
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        shapeView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(300)
        }
        
        startButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(100)
            make.bottom.equalToSuperview().inset(view.bounds.width / 6)
            make.height.equalTo(60)
        }
    }
    func animateButton() {
        
        UIView.animate(withDuration: 0.6) {
            self.startButton.frame.origin.y -= self.startButton.frame.height - 200
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            self.startButton.isHidden = true
        }
    }
    
    func setImageViewTapped() {

        secondView.frame.size.width = 100
        secondView.frame.size.height = 100
        secondView.frame = CGRect(x: view.center.x - secondView.bounds.size.width/2,
                                  y: view.center.y - secondView.bounds.size.height/2,
                                  width: 100,
                                  height: 100)
        
        view.addSubview(secondView)
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(editValueTimer))
        secondView.addGestureRecognizer(tapGesture)
    }
    
    @objc func editValueTimer() {
        print("Tap")
        let picker = UIPickerView()
        picker.tintColor = .black
        picker.delegate = self
        picker.dataSource = self
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: .none, action: #selector(pressDone))
        toolbar.setItems([.flexibleSpace(), doneButton,], animated: true)
        textField.inputAccessoryView = toolbar
        
        textField.delegate = self
        textField.isHidden = true
        secondView.addSubview(textField)
        textField.inputView = picker
        textField.becomeFirstResponder()
    }
    
    @objc func pressDone() {
        self.view.endEditing(true)
    }
}


