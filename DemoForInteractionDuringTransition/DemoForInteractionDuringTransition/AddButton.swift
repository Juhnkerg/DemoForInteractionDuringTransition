//
//  AddButton.swift
//  DemoForInteractionDuringTransition
//
//  Created by Junkai Zheng on 2024/6/13.
//

import UIKit

class AddButton: UIButton {
    
    private var action: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    override var isHighlighted: Bool {
        didSet {
            super.isHighlighted = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        let buttonSize = 55.0
        
        self.frame.size = CGSize(width: buttonSize, height: buttonSize)
        
        self.backgroundColor = UIColor(hex: 0x509CFE)
        
        self.layer.cornerRadius = buttonSize / 2
        self.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.15).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 1
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 0.3
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: buttonSize / 2).cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        gradientLayer.mask = shapeLayer
        
        self.layer.addSublayer(gradientLayer)
        
        let configuration = UIImage.SymbolConfiguration(pointSize: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize, weight: .light)
        let plusImage = UIImage(systemName: "plus", withConfiguration: configuration)
        self.setImage(plusImage, for: .normal)
        self.tintColor = .white
        
        self.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let margin: CGFloat = 10
        let centerPoint = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let radius = self.bounds.width / 2 + margin
        let touchDistance = sqrt(pow(point.x - centerPoint.x, 2) + pow(point.y - centerPoint.y, 2))
        return touchDistance <= radius
    }
    
    @objc private func onButtonTapped() {
        action?()
    }

    func addAction(_ action: @escaping () -> Void) {
        self.action = action
    }
}
