//
//  MainViewController.swift
//  DPHorizontalRoundImageListViewSample-Swift
//
//  Created by DP on 2020/6/15. 
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import DPHorizontalRoundImageListView

class MainViewController: UITableViewController {
    
    lazy var items = [
        Item(spacing: 10),
        Item(spacing: -10)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MyXIBCell", bundle: nil), forCellReuseIdentifier: "MyCell-XIB")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell-XIB", for: indexPath) as! MyXIBCell
        cell.selectionStyle = .none
        cell.imageListView.spacing = items[indexPath.row].spacing ?? 10
        cell.imageListView.itemBorderWidth = 5
        cell.imageListView.itemBorderColor = .lightGray
        cell.imageListView.delegate = self
        
        cell.imageListView.items = [
            .image(UIImage(named: "cat_01")!),
            .image(UIImage(named: "cat_02")!),
            .image(UIImage(named: "cat_03")!),
            .image(UIImage(named: "cat_04")!),
//            .image(UIImage(named: "cat_05")!),
//            .image(UIImage(named: "cat_06")!),
        ]
        
        return cell
    }
}

// MARK: - HorizontalRoundImageListViewDelegate
extension MainViewController: HorizontalRoundImageListViewDelegate {
    
    func horizontalRoundImageListView(_ listView: HorizontalRoundImageListView, didTapItemViewAtIndex index: Int) {
        print("\(#function) - \(index)")
    }
}

extension MainViewController {
    struct Item {
        var spacing: CGFloat?
    }
}
