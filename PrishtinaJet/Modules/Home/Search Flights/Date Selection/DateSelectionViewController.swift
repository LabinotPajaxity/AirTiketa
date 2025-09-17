//
//  DateSelectionViewController.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/22/21.
//

import UIKit
import FSCalendar

protocol DateSelectionViewControllerDelegate: AnyObject {
    func didSetDepartureDate(date: String)
    func didSetArrivalDate(date: String)
}

class DateSelectionViewController: ModalViewController {
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar.newAutoLayout()
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.titleDefaultColor = .gray
        calendar.appearance.todayColor = .orange
        calendar.appearance.selectionColor = AppColors.lightBlue
        calendar.allowsMultipleSelection = true
        calendar.swipeToChooseGesture.isEnabled = true
        calendar.firstWeekday = 2
        calendar.delegate = self
        return calendar
    }()
    
    private lazy var dateSelectionHeader: DateSelectionHeader = {
        let view = DateSelectionHeader.newAutoLayout()
        view.delegate = self
        return view
    }()
    
    private var isArrival = false
    weak var delegate: DateSelectionViewControllerDelegate?
    
    let viewModel: DateSelectionViewModel
    var oneWayTrue: Bool?
    var getIfJustReturnDateFlight: Bool?
    
    init(viewModel: DateSelectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        bottomView.delegate = self
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if getIfJustReturnDateFlight == true {
            dateSelectionHeader.setViewActive(isFirst: false)
            isArrival = true
            viewModel.getAvailableArrivalFlights()
        } else {
            isArrival = false
            viewModel.getAvailableDepartureFlights()
        }
    }
    
    override func viewDidLoad() {
        shouldDisplayBottomView = true
        super.viewDidLoad()
        titleLabel.text = viewModel.inputView.model == .departure ? "Choose Departure Date" : "Choose Return Date"
        
        viewModel.getAvailableDepartureFlights()
    }
    
    override func addSubviews() {
        super.addSubviews()
        
        [dateSelectionHeader, calendar].forEach(view.addSubview)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        dateSelectionHeader.autoPinBelow(view: topBarView, top: 24, left: 24, right: 24)
        calendar.autoPinEdge(.top, to: .bottom, of: dateSelectionHeader, withOffset: 24)
        calendar.autoPinSidesSuperView()
        calendar.autoPinEdge(.bottom, to: .top, of: bottomView)
    }
    
    private func isAvailableDate(_ date: Date) -> Bool {
        let dates = isArrival ? viewModel.arrivalDates : viewModel.departureDates
        for dateString in dates {
            if let availableDate = DateHelper.getDate(dateString) {
                if Calendar.current.isDateInToday(date) {
                    return false
                }
                
                if let selectedDate = calendar.selectedDate {
                    if selectedDate > date && isArrival {
                        return false
                    }
                }
                
                if Calendar.current.isDate(availableDate, equalTo: date, toGranularity: .day) {
                    return true
                }
            }
        }
        return false
    }
    
    private func performDateDeselect(date: Date) {
        let sorted = calendar.selectedDates.sorted { $0 < $1 }
        for date in sorted {
            if date != sorted.first {
                calendar.deselect(date)
            }
        }
    }

    private func performDateSelection() {
        let sorted = calendar.selectedDates.sorted { $0 < $1 }
        if let firstDate = sorted.first, let lastDate = sorted.last {
            let ranges = datesRange(from: firstDate, to: lastDate)
            for date in ranges {
                calendar.select(date)
            }
        }
    }
    
    private func oneWayDateSelection(){
        let sorted = calendar.selectedDates.sorted { $0 < $1 }
        let firstDate = sorted.first!
        let ranges = oneWayDateRange(from: firstDate)
        for date in ranges {
            calendar.select(date)
        }
    }
    
    private func ifSelectJustReturn(){
        let sorted = calendar.selectedDates.sorted { $1 < $0 }
        let to = sorted.last!
        let ranges = justReturnDateRange(to: to)
        for date in ranges {
            calendar.select(date)
        }
    }

    private func datesRange(from: Date, to: Date) -> [Date] {
        if from > to {
            return [Date]()
        }
        var tempDate = from
        var array = [tempDate]
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        return array
    }
    
    private func oneWayDateRange(from: Date) -> [Date] {
            return [Date]()
    }
    private func justReturnDateRange(to: Date) -> [Date] {
        return [Date]()
    }
    
}

extension DateSelectionViewController: DateSelectionViewModelDelegate {
    func didGetDates() {
        calendar.reloadData()
    }
}

extension DateSelectionViewController: DateSelectionHeaderDelegate {
    func didSelectHeader(isArrival: Bool) {
        self.isArrival = isArrival
        for date in calendar.selectedDates {
            calendar.deselect(date)
        }
        calendar.reloadData()
    }
}

extension DateSelectionViewController: ModalBottomViewDelegate {
    func didtapOnChooseButton() {
        let dates = calendar.selectedDates.sorted()
        if getIfJustReturnDateFlight == true {
            if let lastDate = dates.last {
                delegate?.didSetArrivalDate(date: DateHelper.formatDate(lastDate, format: "dd/MM/yyyy"))
                dismiss(animated: true, completion: nil)
            }
        } else {
            if let startDate = dates.first {
                delegate?.didSetDepartureDate(date: DateHelper.formatDate(startDate, format: "dd/MM/yyyy"))
                if let lastDate = dates.last, dates.count > 1 {
                    delegate?.didSetArrivalDate(date: DateHelper.formatDate(lastDate, format: "dd/MM/yyyy"))
                }
                dismiss(animated: true, completion: nil)
            }
        }
        
    }
}

extension DateSelectionViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return isAvailableDate(date) ? .black : .none
    }
}

extension DateSelectionViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return isAvailableDate(date) ? true : false
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if dateSelectionHeader.isDepartureSelected {
            
            if getIfJustReturnDateFlight == true {
                ifSelectJustReturn()
                dateSelectionHeader.setViewActive(isFirst: false)
                isArrival = true
                viewModel.getAvailableArrivalFlights()
            }
//
            if oneWayTrue == true {
                oneWayDateSelection()
                dateSelectionHeader.setViewActive(isFirst: true)
                isArrival = false
//                viewModel.getAvailableDepartureFlights()
                let dates = calendar.selectedDates.sorted()
                let startDate = dates.first
                delegate?.didSetDepartureDate(date: DateHelper.formatDate(startDate!, format: "dd/MM/yyyy"))
                    
                dismiss(animated: true, completion: nil)
                
            } else {
                dateSelectionHeader.setViewActive(isFirst: false)
                isArrival = true
                viewModel.getAvailableArrivalFlights()
            }
            
        } else {
            performDateSelection()
        }
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if isAvailableDate(date) {
            performDateDeselect(date: date)
            return true
        }
        return false
    }
}
