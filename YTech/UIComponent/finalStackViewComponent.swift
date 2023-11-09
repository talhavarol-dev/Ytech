//
//  finalStackViewComponent.swift
//  YTech
//
//  Created by Muhammet  on 9.11.2023.
//

import Foundation
import UIKit
import SnapKit

final class FinalStackComponent: UIStackView {
    let orderNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Sipariş No:23132131"
        label.numberOfLines = 1
        label.font = UIFont(name: "Jost-Regular", size: 12)
        label.textColor = .systemGray
        return label
    }()
    
    let orderDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Bugün 14:00- 16:00"
        label.numberOfLines = 1
        label.font = UIFont(name: "Jost-Regular", size: 12)
        label.textColor = .systemGray
        return label
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
        addArrangedSubview(orderNumberLabel)
        addArrangedSubview(orderDateLabel)
    }
}
