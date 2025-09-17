//
//  SideMenuViewController.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/11/21.
//

import UIKit

class SideMenuViewController: UIViewController {
    private lazy var languageBarButton: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "us-flag"), for: .normal)
        button.setTitle("English", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        button.addTarget(self, action: #selector(languageBarButtonAction), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        barButton.tintColor = .clear
        return barButton
    }()
    
    private lazy var closeBarButton: UIBarButtonItem = {
        let closeIcon = UIImage(named: "close-white")
        let barButton = UIBarButtonItem(image: closeIcon,
                                        style: .plain,
                                        target: self,
                                        action: #selector(closeBarButtonAction))
        barButton.tintColor = .white
        return barButton
    }()
    
    private var footerLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.text = "©SouthEast.2021"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.newAutoLayout()
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellClass: SideMenuTableViewCell.self)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let data = SideMenuItem.dataSource()
    var selectedRow = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.mainColor
        
        setupNavigationBar()
        addSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.selectRow(at: IndexPath(row: selectedRow, section: 0), animated: false, scrollPosition: .none)
    }
    
    private func setupNavigationBar() {
        let seperatorBarButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        seperatorBarButton.width = 14
        navigationItem.leftBarButtonItems = [seperatorBarButton, languageBarButton]
        navigationItem.rightBarButtonItem = closeBarButton
        
        navigationController?.navigationBar.barTintColor = AppColors.mainColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        extendedLayoutIncludesOpaqueBars = true
//        if #available(iOS 15, *) {
//            navigationController?.navigationBar.barTintColor = AppColors.mainColor
//            navigationController?.navigationBar.isTranslucent = false
//            navigationController?.navigationBar.shadowImage = UIImage()
//            extendedLayoutIncludesOpaqueBars = true
//        }

    }
    
    @objc private func languageBarButtonAction() {
        print("Language")
    }
    
    @objc private func closeBarButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    private func addSubviews() {
        [tableView, footerLabel].forEach(view.addSubview)
    }
    
    private func setupConstraints() {
        tableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 40, left: 0, bottom: 30, right: 0))
        footerLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        footerLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 24)
    }
}

// MARK: - UITableViewDataSource
extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SideMenuTableViewCell = tableView.dequeueReusableCell(for: indexPath) else {
            fatalError("Unregistered cell")
        }
        cell.setup(with: data[indexPath.row], isSelected: selectedRow == indexPath.row)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SideMenuViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? SideMenuTableViewCell
        cell?.setSelected(true, animated: true)
        selectedRow = indexPath.row
        
        let menuItemTitle = SideMenuItem.dataSource()[selectedRow].title
        
        switch menuItemTitle {
        case "Home":
            print("Goto hom")
        case "Bookings":
            
            let storyboard = UIStoryboard(name: "MyBookings", bundle: nil)
            let profileVC = storyboard.instantiateViewController(identifier: "BookingViewController")
            navigationController?.pushViewController(profileVC, animated: true)
            
//        case "Passes":
//            print("Goto Passes")
            
        case "Profile":
            let storyboard = UIStoryboard(name: "Profile", bundle: nil)
            let profileVC = storyboard.instantiateViewController(identifier: "ProfileViewController")
            navigationController?.pushViewController(profileVC, animated: true)
            
        case "Logout":
            showConfirmalert(message: "Are you sure you want to logout?") {
                KeychainManager.shared.clearAll()
                self.dismiss(animated: true, completion: nil)
            }
            
        case "Login":
            let loginVC = LoginViewController()
            navigationController?.pushViewController(loginVC, animated: true)
        default:
            return
        }
    }
}
