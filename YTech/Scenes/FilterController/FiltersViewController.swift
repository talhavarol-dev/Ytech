//
//  FiltersViewController.swift
//  YTech
//
//  Created by Muhammet  on 8.11.2023.
//

import UIKit

protocol FilterOutput: AnyObject {
    func didSelectFilter(index: Int)
}

final class FiltersViewController: UIViewController {
    //MARK: - Properties
    var filters = [Content]()
    weak var delegate: FilterOutput?
    
    //MARK: - UI Elements
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        return view
    }()
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 5
        view.tintColor = .black
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.rowHeight = 50
        return tableView
    }()
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    //MARK: - Functions
    private func drawDesing(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: FilterTableViewCell.Identifier.custom.rawValue)
    }
    
    private func configure() {
        view.addSubview(containerView)
        containerView.addSubview(lineView)
        containerView.addSubview(tableView)
        drawDesing()
        configureConstrains()
    }
    
}
    //MARK: - Extension
extension FiltersViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: FilterTableViewCell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.Identifier.custom.rawValue) as? FilterTableViewCell else { return UITableViewCell()}
        cell.label.text = filters[indexPath.row].value
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectFilter(index: indexPath.row)
        dismiss(animated: true)
    }
    
}
extension FiltersViewController{
    private func configureConstrains(){
        containerView.snp.makeConstraints { make in
            // make.edges.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(400)
        }
        lineView.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12)
            make.width.equalTo(70)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
