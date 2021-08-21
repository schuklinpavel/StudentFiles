//
//  StudentTableViewCell.swift
//  StudentFiles
//
//  Created by Pasha on 27.07.2021.
//

import UIKit

class StudentTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(with student: Student) {
        titleLabel.text = "\(student.lastName) \(student.firstName)"
        detailLabel.text = "\(student.averageScore)"
    }
}
