//
//  MonthCollectionView.swift
//  PrishtinaJet
//
//  Created by Blerd Foniqi on 2/26/21.
//

import UIKit

typealias SelectDateHandler = (_ day: String) -> ()

class MonthCollectionView: UICollectionView {
    var heightConstraint: NSLayoutConstraint?
    var keyValueObservationToken: NSKeyValueObservation?
    
    var date: Date? {
        didSet {
            reloadData()
        }
    }
    
    var selectDateHandler: SelectDateHandler?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        super.init(frame: frame, collectionViewLayout: layout)
                
        backgroundColor = .systemBackground
        isScrollEnabled = false
        register(cellClass: DayCollectionViewCell.self)
        dataSource = self
        delegate = self
        setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        heightConstraint = autoSetDimension(.height, toSize: 300)
        heightConstraint?.priority = UILayoutPriority(999)
        keyValueObservationToken = observe(\.contentSize, options: [.new]) { [weak self] _, change in
            if let newContentSize = change.newValue {
                self?.heightConstraint?.constant = newContentSize.height
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        keyValueObservationToken?.invalidate()
    }
}

extension MonthCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfDays = date?.numberOfDaysInMonth,
              let firstDayWeekday = date?.firstDayWeekday  else {
            return 0
        }
        return numberOfDays + firstDayWeekday - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: DayCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath) else {
            fatalError("Unregistered Cell")
        }
        let firstDayWeekday = date?.firstDayWeekday ?? 0
        if indexPath.row >= firstDayWeekday - 1 {
            cell.dayLabel.text = "\(indexPath.row - firstDayWeekday + 2)"
        }
        return cell
    }
}

extension MonthCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DayCollectionViewCell else {
            fatalError("Unregistered cell")
        }
        if let day = cell.dayLabel.text, !day.isEmpty {
            selectDateHandler?(day)
        }
    }
}

extension MonthCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 7
        return CGSize(width: size, height: size)
    }
}
