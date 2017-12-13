//
//  PrayerViewController.swift
//  LearnToPray
//
//  Created by Mark Tapia on 12/4/17.
//  Copyright © 2017 Mark Tapia. All rights reserved.
//

import UIKit

protocol DetailsListDelegate {
    var prayer: Prayer? { get set }
}

class DetailsContainerViewController: CoreDataViewController {
    
    var delegate: DetailsListDelegate?

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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionCell = tableView.dequeueReusableCell(withIdentifier: "sectionHeaderCell") as? PrayerDetailsHeaderTableViewCell else {
            fatalError("Check tableView for cell with identifier \"sectionHeaderCell\"")
            
        }
        
        guard let prayer = delegate?.prayer else {
            fatalError("Prayer or delegate not set in viewForHeaderInSection")
        }
        
        sectionCell.prayerNameLabel.text = prayer.name
        sectionCell.prayerTextLabel.text = prayer.text
        
        return sectionCell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        return cell
    }
}
