//
//  SelectAirportViewController.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/2/21.
//

import UIKit

class SelectAirportViewController: ModalViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView.newAutoLayout()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellClass: AirportTableViewCell.self)
        tableView.register(headerFooterView: TitleHeaderView.self)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()

    let viewModel: SelectAirportViewModel
    
    init(viewModel: SelectAirportViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default
                   .addObserver(self,
                    selector: #selector(statusManager),
                    name: .flagsChanged,
                    object: nil)
        updateUserInterface()
        titleLabel.text = viewModel.inputView.model == .from ? "Leaving from" : "Leaving to"
        
        viewModel.getAirports()
    }
    
    override func addSubviews() {
        super.addSubviews()
        [tableView].forEach(view.addSubview)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        tableView.autoPinEdgesSuperViewAndBelow(view: topBarView)
    }

}

extension SelectAirportViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.countriesCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.country(at: section).airports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: AirportTableViewCell = tableView.dequeueReusableCell(for: indexPath) else {
            fatalError("Unregistred cell")
        }
        let airport = viewModel.airport(at: indexPath)
        let countryCode = viewModel.country(at: indexPath.section).code  
        cell.configure(with: airport, countryCode: countryCode)
        return cell
    }

}

extension SelectAirportViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let airport = viewModel.airport(at: indexPath)
        viewModel.select(airport: airport)
        dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView: TitleHeaderView = tableView.dequeueReusableHeaderFooterView() else {
            fatalError("Unregistered header view")
        }
        headerView.title = viewModel.country(at: section).name
        return headerView
    }
    
    
}

extension SelectAirportViewController: SelectAirportViewModelDelegate {
    func didFetchCountries() {
        tableView.reloadData()
    }
    
    func didFailToFetchCountries(with errorMessage: String) {
        
    }
}
