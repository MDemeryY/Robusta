//
//  RepositoryCell.swift
//  Robusta_Task
//
//  Created by Mahmoud ELDemery on 17/07/2021.
//

import UIKit

class RepositoryCell: UICollectionViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var ownerAvatarImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configCell(repo:RepositoryResponse, index:Int) {
        idLabel.text = "\(index)"
        repoNameLabel.text = repo.name
        ownerNameLabel.text = repo.full_name
        ownerAvatarImageView.downloaded(from: repo.owner.avatar_url )


    }
}
