//
//  NoteCell.swift
//  BankNote
//
//  Created by 林逸凡 on 2017/9/4.
//  Copyright © 2017年 Ivan.lin. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
