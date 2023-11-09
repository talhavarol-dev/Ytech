//
//  PastOrderViewController.swift
//  YTech
//
//  Created by Muhammet  on 6.11.2023.
//

import UIKit
import SnapKit


final class PastOrderViewController: UIViewController {
    //MARK: - Properties
    let filtersViewController = FiltersViewController()
    
    private lazy var pastOrders = [ContentResult]()
    private lazy var filters = [Content]()
    
    private var viewModel: PastOrderViewModelProtocol = PastOrderViewModel(service: Services())
    
    //MARK: - UI Elements
    private let containerView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    private let orderLabel: UILabel = {
        let label = UILabel()
        label.text = "Tüm Siparişler"
        label.textColor = .systemGray2
        label.font = UIFont(name: "Jost-Bold", size: 14)
        label.numberOfLines = 0
        return label
    }()
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 5.0
        stackView.backgroundColor = .systemGray6
        return stackView
    }()
    private let filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing   = 1.0
        return stackView
    }()
    private let filterNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Son 1 ay"
        label.textColor = .systemGray2
        label.font = UIFont(name: "Jost-Bold", size: 14)
        label.numberOfLines = 0
        return label
    }()
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .systemGray2
        button.addTarget(self, action: #selector(filterButtonTap), for: .touchUpInside)
        return button
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray6
        tableView.rowHeight = 230
        return tableView
    }()
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .black
        return indicator
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        bind()
        configure()
        controlFilterName()
    }
    //MARK: - Functions
    private func drawDesing(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PastOrderTableViewCell.self, forCellReuseIdentifier: PastOrderTableViewCell.Identifier.custom.rawValue)
        navigationItem.title = "Siparişlerim"
        let backButtonImage = UIImage(systemName: "arrow.left")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: .none)
        navigationItem.leftBarButtonItem = backButton
        view.backgroundColor = .systemGray6
    }
    private func configure() {
        view.addSubview(tableView)
        view.addSubview(containerView)
        view.addSubview(indicator)
        containerView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(orderLabel)
        containerStackView.addArrangedSubview(filterStackView)
        filterStackView.addArrangedSubview(filterNameLabel)
        filterStackView.addArrangedSubview(filterButton)
        drawDesing()
        configureConstrains()
    }
    // Dispatch Global kullanacak kadar kafam kalmadı.
    private func bind(){
        indicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.fetchPastOrders()
        }
    }
    private func fetchPastOrders(){
        viewModel.fetchPastOrders { [weak self] orders in
            guard let orders = orders?.content else {return}
            self?.pastOrders = orders
            DispatchQueue.main.async {
                self?.fetchFilters()
            }
        } onError: { error in
            self.indicator.stopAnimating()
        }
    }
    private func fetchFilters(){
        viewModel.fetchFilter { [weak self] filters in
            guard let filters = filters?.content else {return}
            self?.filters = filters
            print(filters)
            DispatchQueue.main.async {
                self?.setUI()
            }
        } onError: { error in
            self.indicator.stopAnimating()
        }
    }
    private func setUI(){
        containerView.isHidden = false
        tableView.reloadData()
        indicator.stopAnimating()
    }
    @objc func filterButtonTap(){
        let vc = FiltersViewController()
        vc.filters = self.filters
        vc.delegate = self
        present(vc, animated: true)
    }
    
}
//MARK: - Extension
extension PastOrderViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pastOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PastOrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: PastOrderTableViewCell.Identifier.custom.rawValue) as? PastOrderTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.configure(with: pastOrders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = pastOrders[indexPath.row]
        if let orderId = order.orderId {
            let title = "Sipariş ID"
            let message = "Sipariş ID: \(orderId)"
            CustomAlertDialog.showAlert(from: self, withTitle: title, message: message)
        }
    }
}
extension PastOrderViewController{
    private func configureConstrains() {
        
        containerView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        containerStackView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top)
            make.left.right.bottom.equalToSuperview()
            make.bottom.equalTo(containerView.snp.bottom)
            make.height.equalTo(50)
        }
        orderLabel.snp.makeConstraints { make in
            make.centerY.equalTo(containerStackView)
            make.leading.equalTo(containerStackView).offset(20)
        }
        filterStackView.snp.makeConstraints { make in
            make.centerY.equalTo(containerStackView)
        }
        filterNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(filterStackView)
            make.centerY.equalTo(filterStackView)
        }
        filterButton.snp.makeConstraints { make in
            make.trailing.equalTo(filterStackView)
            make.centerY.equalTo(filterStackView)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(containerStackView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
extension PastOrderViewController: FilterOutput {
    func didSelectFilter(index: Int) {
        guard let title = filters[index].value else { return }
        UserDefaults.standard.set(title, forKey: "selectedFilter")
        filterNameLabel.text = title
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            CustomAlertDialog.showAlert(from:self, withTitle: "Seçilen Filtre", message:title)
        }
    }
    func controlFilterName(){
        if let savedFilter = UserDefaults.standard.string(forKey: "selectedFilter") {
            filterNameLabel.text = savedFilter
        }
    }
}

