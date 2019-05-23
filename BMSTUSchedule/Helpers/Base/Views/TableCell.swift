//
//  TableCell.swift
//  BMSTUSchedule
//
//  Created by Artem Belkov on 23/05/2019.
//  Copyright © 2019 BMSTU Team. All rights reserved.
//

import UIKit

protocol TableCellDelegate: AnyObject {}

class TableCell: UITableViewCell {
    weak var delegate: TableCellDelegate?
}
