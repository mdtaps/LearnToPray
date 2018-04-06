//
//  PrayerViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/4/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import UIKit
import CoreData

protocol DetailsListDelegate: NSObjectProtocol {
    var prayer: Prayer? { get set }
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? { get set }
}

class DetailsContainerViewController: CoreDataViewController {
    
    weak var delegate: DetailsListDelegate?

    @IBOutlet weak var prayerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewDelegates()
        
    }
    
    private func setTableViewDelegates() {
        prayerTableView.delegate = self
        prayerTableView.dataSource = self
    }
    
}

extension DetailsContainerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return delegate?.prayer?.details?.count ?? 0
    }
    
    //MARK: Table View Header Delegate Functions
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionCell = tableView.dequeueReusableCell(withIdentifier: "sectionHeaderCell") as? PrayerDetailsHeaderTableViewCell else {
            fatalError("Check tableView for cell with identifier \"sectionHeaderCell\"")
            
        }
        
        guard let prayer = delegate?.prayer else {
            fatalError("Prayer or delegate not set in viewForHeaderInSection")
            
        }
        
        //Set section cell title and description text from Prayer Detail data
        sectionCell.prayerNameLabel.text = prayer.name
        sectionCell.prayerTextLabel.text = prayer.text
        
        return sectionCell
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as? PrayerDetailsTableViewCell else {
            fatalError("Check tableView for cell with identifier \"detailCell\"")
            
        }
        
        guard let detail = delegate?.fetchedResultsController?.object(at: indexPath) as? Details else {
            return cell
            
        }
        
        //Set cell title and description text from Prayer Detail data
        cell.detailsTitleLabel.text = detail.title
        cell.detailsTextLabel.text = detail.text
        
        return cell
    }
}
