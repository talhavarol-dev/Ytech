//
//  topStackView.swift
//  YTech
//
//  Created by Muhammet  on 9.11.2023.
//

import Foundation
import UIKit
import SnapKit
class TopStackComponent: UIStackView {
    let orderLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "orderColor")
        label.font = UIFont(name: "Jost-Bold", size: 14)
        return label
    }()
    
    let orderDetailButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .center
        spacing = 5.0
        
        addArrangedSubview(orderLabel)
        addArrangedSubview(orderDetailButton)
    }
}
