//
//  CountriesViewController.swift
//  PrishtinaJet
//
//  Created by Nikola Dojchinovski on 27.5.21.
//

import UIKit

protocol CountriesViewControllerDelegate: AnyObject {
    func didSelect(country: Country)
}

class CountriesViewController: ModalViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView.newAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellClass: CountriesTableViewCell.self)
        return tableView
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.backgroundColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        return searchController
    }()
    
    let viewModel: CountriesViewModel
    
    var searchArray = [Country]()
    var isSearching = false
    weak var delegate: CountriesViewControllerDelegate?
    
    init() {
        viewModel = CountriesViewModel()
        super.init(nibName: nil, bundle: nil)
        addSubviews()
        setupConstraints()
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        titleLabel.text = "Choose location"
        tableView.tableHeaderView = searchController.searchBar
        viewModel.getCountries()
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        tableView.autoPinBelow(view: topBarView)
        tableView.autoPinEdge(toSuperviewSafeArea: .bottom)
    }
}

extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? searchArray.count : viewModel.countriesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CountriesTableViewCell = tableView.dequeueReusableCell(for: indexPath) else {
            fatalError("Unregistered cell")
        }
        let country = isSearching ? searchArray[indexPath.row] : viewModel.country(at: indexPath.row)
        cell.textLabel?.text = country.name
        
        return cell
    }
}

extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = isSearching ? searchArray[indexPath.row] : viewModel.country(at: indexPath.row)
        delegate?.didSelect(country: country)
//        self.dismiss(animated: true, completion: nil)
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)

    }
}

extension CountriesViewController: CountriesViewModelDelegate {
    func didGetCountries() {
        tableView.reloadData()
    }
    
    func didGetFailure() {
        
    }
}
