//
//  bottomStackView.swift
//  YTech
//
//  Created by Muhammet  on 9.11.2023.
//
import UIKit
import SnapKit

final class BottomStackViewComponent: UIStackView {
    let adressStackView: AddressStackViewComponent = {
        let stackView = AddressStackViewComponent()
        return stackView
    }()
    
    let totalAmountStackViewComponent: TotalAmountStackComponent = {
        let stackView = TotalAmountStackComponent()
        return stackView
    }()
    
    private let middleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 5.0
        return stackView
    }()
    
    private let bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    let finalStackView: FinalStackComponent = {
        let stackView = FinalStackComponent()
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        axis = .vertical
        distribution = .fillProportionally
        alignment = .leading
        spacing = 5.0
        
        addArrangedSubview(adressStackView)
        addArrangedSubview(middleStackView)
        middleStackView.addArrangedSubview(totalAmountStackViewComponent)
        addArrangedSubview(bottomLineView)
        addArrangedSubview(finalStackView)
    }
    private func configureConstraints() {
        adressStackView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().inset(12)
            make.height.equalTo(32)
        }
        middleStackView.snp.makeConstraints { make in
            make.left.right.equalTo(adressStackView)
            make.height.equalTo(40)
        }
        totalAmountStackViewComponent.snp.makeConstraints { make in
        }
        bottomLineView.snp.makeConstraints { make in
            make.left.right.equalTo(adressStackView)
            make.height.equalTo(1)
        }
        
        finalStackView.snp.makeConstraints { make in
            make.left.right.equalTo(adressStackView)
            make.bottom.equalToSuperview().inset(12)
            make.height.equalTo(32)
        }
    }
    
}

