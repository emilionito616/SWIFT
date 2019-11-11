//
//  TableViewCell.swift
//  proyecto_v1.0
//
//  Created by Labdesarrollo.3 on 10/8/19.
//  Copyright © 2019 Labdesarrollo.3. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblCod: UILabel!
    
    @IBOutlet weak var lblCom: UILabel!
    
    @IBOutlet weak var lblExist: UILabel!
    
    @IBOutlet weak var lblPrec: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
