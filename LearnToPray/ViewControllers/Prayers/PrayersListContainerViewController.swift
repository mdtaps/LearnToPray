//
//  PrayersListContainerViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 11/9/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import UIKit

protocol PrayersListDelegate {
    func didSelectPrayer(prayerName: String)
}

class PrayersListContainerViewController: CoreDataViewController {

    @IBOutlet weak var prayersTableView: UITableView!
    
    var delegate: PrayersListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up delegates
        prayersTableView.delegate = self
        prayersTableView.dataSource = self
        
        fetchedResultsController = createFetchedResultsController(for: Prayer.self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PrayersListContainerViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Number of Sections/Rows Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = fetchedResultsController?.sections?.count else {
            fatalError("No sections to return in numberOfSections")
        }
        
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
        let sectionHeader = tableView.dequeueReusableCell(withIdentifier: "section")!
        guard let prayer = fetchedResultsController?.object(at: IndexPath(row: 0, section: section)) as? Prayer else {
            fatalError("Could not get an object for section \(section)")
            
        }
        
        sectionHeader.textLabel?.text = prayer.category.name
        return sectionHeader
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
       
        guard let prayer = fetchedResultsController?.object(at: indexPath) as? Prayer else {
            fatalError("Could not get an object for indexPath \(indexPath)")
            
        }
        cell.textLabel?.text = prayer.name
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        guard let prayerName = cell?.textLabel?.text else {
            fatalError("Could not get prayerName from cell in didSelectRowAtIndexPath")
        }
        
        delegate?.didSelectPrayer(prayerName: prayerName)
    }
    
}

