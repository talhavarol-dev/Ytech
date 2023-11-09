//
//  ActiveOrderViewController.swift
//  YTech
//
//  Created by Muhammet  on 6.11.2023.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    //MARK: - Properties
    private var firstViewController = ActiveOrderViewController()
    private var secondViewController =  PastOrderViewController()
    //MARK: - UI Elements
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Aktif Siparişler", "Geçmiş Siparişler"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .white
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.layer.cornerRadius = 0
        segmentedControl.layer.masksToBounds = true
        return segmentedControl
    }()
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        addChild(firstViewController)
        firstViewController.didMove(toParent: self)
        containerView.addSubview(firstViewController.view)
        segmentedControlValueChanged(segmentedControl)
    }
    //MARK: - Functions
    private func drawDesing(){
        navigationItem.title = "Siparişlerim"
        let backButtonImage = UIImage(systemName: "arrow.left")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: .none)
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func configure(){
        view.addSubview(segmentedControl)
        view.addSubview(containerView)
        drawDesing()
        configureConstrains()
    }
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            switchViewController(from: secondViewController, to: firstViewController)
        } else {
            switchViewController(from: firstViewController, to: secondViewController)
        }
    }
    
    private func switchViewController(from: UIViewController?, to: UIViewController?) {
        if let fromViewController = from {
            fromViewController.willMove(toParent: nil)
            fromViewController.view.removeFromSuperview()
            fromViewController.removeFromParent()
        }
        
        if let toViewController = to {
            addChild(toViewController)
            toViewController.didMove(toParent: self)
            containerView.addSubview(toViewController.view)
            toViewController.view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}
//MARK: - Extension
extension HomeViewController {
    private func configureConstrains() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view.safeAreaLayoutGuide)
        }
        containerView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.right.equalTo(segmentedControl)
        }
        
    }
}

