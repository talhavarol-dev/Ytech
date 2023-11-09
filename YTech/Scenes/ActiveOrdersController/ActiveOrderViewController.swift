//
//  HomeViewController.swift
//  YTech
//
//  Created by Muhammet  on 6.11.2023.
//
import UIKit
import SnapKit

final class ActiveOrderViewController: UIViewController {
    //MARK: - UI Elements
    private lazy var activeOrders = [ContentResult]()
    private var viewModel: ActiveOrderViewModelProtocol = ActiveOrderViewModel(service: Services())
    
    //MARK: - UI Elements
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray6
        tableView.rowHeight = 230
        return tableView
    }()
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    private let basketStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 0.5
        stackView.backgroundColor = .systemGray5
        stackView.layer.cornerRadius = 4
        stackView.backgroundColor = .clear
        return stackView
    }()
    private let basketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "basketIcon")
        return imageView
    }()
    private let orderLabel: UILabel = {
        let label = UILabel()
        label.text = "Aktif Siparişiniz Bulunmamaktadır."
        label.textColor = UIColor(named: "primaryBlue")
        label.font = UIFont(name: "Jost-Bold", size: 14)
        label.numberOfLines = 0
        return label
    }()
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTableView()
    }
    //MARK: - Functions
    private func drawDesing() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ActiveOrderTableViewCell.self, forCellReuseIdentifier: ActiveOrderTableViewCell.Identifier.custom.rawValue)
        navigationItem.title = "Siparişlerim"
        let backButtonImage = UIImage(systemName: "arrow.left")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: .none)
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func configure() {
        view.addSubview(tableView)
        view.addSubview(basketStackView)
        basketStackView.addArrangedSubview(basketImageView)
        basketStackView.addArrangedSubview(orderLabel)
        drawDesing()
        configureConstrains()
    }
    
    private func configureTableView() {
        tableView.refreshControl = refreshControl
    }
    
    private func fetchActiveOrders() {
        viewModel.fetchActiveOrders { [weak self] orders in
            guard let orders = orders?.content else {return}
            self?.activeOrders = orders
            dump(orders)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.basketStackView.isHidden = true
                self?.refreshControl.endRefreshing()
            }
        } onError: { error in
            print(error)
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc private func refreshData() {
        fetchActiveOrders()
    }
}
//MARK: - Extensions
extension ActiveOrderViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(activeOrders.count)
        return activeOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ActiveOrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: ActiveOrderTableViewCell.Identifier.custom.rawValue) as? ActiveOrderTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.configure(with: activeOrders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = activeOrders[indexPath.row]
        if let orderId = order.orderId {
            let title = "Sipariş ID"
            let message = "Sipariş ID: \(orderId)"
            CustomAlertDialog.showAlert(from: self, withTitle: title, message: message)
        }
    }
}

extension ActiveOrderViewController{
    private func configureConstrains(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        basketStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
        }
        basketImageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
    }
}
