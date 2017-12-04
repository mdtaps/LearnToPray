//
//  PrayersListViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 11/9/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import UIKit

class PrayersListViewController: CoreDataViewController {

    @IBOutlet weak var prayersTableView: UITableView!
    
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

extension PrayersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = fetchedResultsController?.sections?.count else {
            print("Sections failed, returning 0 sections")
            return 0
        }
        
        print("Sections count is \(count)")
        return count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController?.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = fetchedResultsController?.sections else {
            fatalError("No sections in fetchedResultsController")
            
        }
        
        if let category = sections[section] as? Category {
            return category.name

        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")!
       
        return cell

    }
    
}

