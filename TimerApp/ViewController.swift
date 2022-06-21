

import SnapKit
import UIKit
import Spring
import AudioToolbox

class ViewController: UIViewController {
    let secondView = UIView()
    let textField = UITextField()
    let nameAppLabel: UILabel = {
        let label = UILabel()
        label.text = "Таймер"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .black
        return label
    }()
    var secondLabel: UILabel = {
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
    let shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    let startButton: SpringButton = {
        let button = SpringButton(type: .system)
        button.setTitle("Старт", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.systemGray.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1
        return button
    }()
    var timer = Timer()
    var durationTimer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        startButtonAnimate()
        view.backgroundColor = .white
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self,action: #selector(editValueTimer))
        secondView.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        self.animationCircular()
    }
}

// MARK: - Metods
extension ViewController {
    @objc func startButtonTapped() {
        durationTimer = Int(secondLabel.text!)!
        guard durationTimer > 0 else { return }
        setBasicAnimation()
        self.animateButton()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        startButton.isEnabled = false
    }
    
    @objc func timerAction() {
        durationTimer = Int(secondLabel.text!)!
        durationTimer -= 1
        secondLabel.text = "\(durationTimer)"
        if durationTimer == 0 {
            self.setAlert()
            timer.invalidate()
            startButton.isEnabled = true
            self.startButton.isHidden = false
            AudioServicesPlaySystemSound(1000)
            startButtonAnimate()
        }
    }
    
    private func animationCircular() {
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
    
    private func setBasicAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = CFTimeInterval(durationTimer)
        animation.toValue = 0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = true
        shapeLayer.add(animation, forKey: nil)
    }
    
    private func setLayout() {
        view.addSubview(nameAppLabel)
        view.addSubview(secondLabel)
        view.addSubview(shapeView)
        view.addSubview(startButton)
        view.addSubview(secondView)
        
        nameAppLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.centerX.equalToSuperview()
        }
        secondLabel.snp.makeConstraints { make in
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
        secondView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
    private func animateButton() {
        UIView.animate(withDuration: 0.6) {
            self.startButton.frame.origin.y -= self.startButton.frame.height - 200
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            self.startButton.isHidden = true
        }
    }
    
    @objc func editValueTimer() {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: .none, action: #selector(pressDone))
        toolbar.setItems([.flexibleSpace(), doneButton,], animated: true)
        textField.inputAccessoryView = toolbar
        textField.isHidden = true
        secondView.addSubview(textField)
        textField.inputView = picker
        textField.becomeFirstResponder()
    }
    
    @objc func pressDone() {
        self.view.endEditing(true)
    }
    private func setAlert() {
        let alert = UIAlertController(title: "Время истекло!", message: nil, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "ОК", style: .cancel) { _ in
            print("Готово")
        }
        
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    private func startButtonAnimate() {
        startButton.animation = "squeezeUp"
        startButton.delay = 0.3
        startButton.duration = 1
        startButton.damping = 1
        startButton.animate()
    }
}


