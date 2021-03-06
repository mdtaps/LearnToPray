//
//  PrayersListContainerViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 11/9/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import UIKit

protocol PrayersListDelegate: NSObjectProtocol {
    func didSelectPrayer(prayer: Prayer)
    var activityIndicator: UIActivityIndicatorView? { get set }
    
}

class PrayersListContainerViewController: CoreDataViewController {    

    @IBOutlet weak var prayersTableView: UITableView!
    
    weak var delegate: PrayersListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up delegates
        prayersTableView.delegate = self
        prayersTableView.dataSource = self
        
        fetchedResultsController = createFetchedResultsController(for: Prayer.self)
        
    }
    
}

extension PrayersListContainerViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Number of Sections/Rows Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        let count = fetchedResultsController?.sections?.count ?? 0
        
        return count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController?.sections else {
            fatalError("No sections in numberOfRowsInSection")
        }
        
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    //MARK: Section Header Functions
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = tableView.dequeueReusableCell(withIdentifier: "section")! as! SectionTableViewCell
        
        //Set section header title for Prayer
        guard let prayer = fetchedResultsController?.object(at: IndexPath(row: 0, section: section)) as? Prayer else {
            fatalError("Could not get an object for section \(section)")
            
        }
        sectionHeader.sectionTitleLabel.text = prayer.category.name
        return sectionHeader
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! PrayerTableViewCell
       
        //Set prayer names in each section
        guard let prayer = fetchedResultsController?.object(at: indexPath) as? Prayer else {
            fatalError("Could not get an object for indexPath \(indexPath)")
            
        }
        cell.prayerTitleLabel.text = prayer.name
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let prayer = fetchedResultsController?.object(at: indexPath) as? Prayer else {
            fatalError("Could not get an object for indexPath \(indexPath)")

        }
        
        let cell = tableView.cellForRow(at: indexPath) as! PrayerTableViewCell
        delegate?.activityIndicator = cell.loadingIndicator
        delegate?.didSelectPrayer(prayer: prayer)
        //Deselect row to get row to un-highlight
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

