//
//  MyXIBCell.swift
//  DPHorizontalRoundImageListViewSample-Swift
//
//  Created by DP on 2020/6/15.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import DPHorizontalRoundImageListView

class MyXIBCell: UITableViewCell {
    
    @IBOutlet weak var imageListView: HorizontalRoundImageListView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
