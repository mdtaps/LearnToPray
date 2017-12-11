//
//  PrayerViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/4/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import UIKit

protocol DetailsListDelegate {
    var prayer: Prayer { get set }
}

class DetailsContainerViewController: CoreDataViewController {
    
    let delegate: DetailsListDelegate?

    @IBOutlet weak var prayerTableView: UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prayerTableView.delegate = self
        prayerTableView.dataSource = self
    }
    
}

extension DetailsContainerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionCell = tableView.dequeueReusableCell(withIdentifier: "sectionHeaderCell") as? PrayerDetailsHeaderTableViewCell else {
            fatalError("Could not find section cell in viewForHeaderInSection")
            
        }
        
        guard let delegate = delegate else {
            fatalError("No prayer set in viewForHeaderInSection")
        }
        
        sectionCell.prayerNameLabel.text = delegate.prayer.text
        sectionCell.prayerTextLabel.text = delegate.prayer.text
        
        return sectionCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        return cell
    }
}
