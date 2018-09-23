//
//  RepositoryTableCell.swift
//  TestApp
//
//  Created by user on 9/23/18.
//  Copyright © 2018 valerii. All rights reserved.
//

import UIKit
import Kingfisher

class RepositoryTableCell: UITableViewCell {
    
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isPrivateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsNumberLabel: UILabel!
 
    //MARK: - Public
    func setup(viewModel: RepositoryTableCellViewModel) {
        titleLabel.text = viewModel.name
        languageLabel.text = viewModel.language
        isPrivateLabel.text = viewModel.isPrivate
        descriptionLabel.text = viewModel.description
        starsNumberLabel.text = viewModel.watchersNumber
        
        ownerImageView.kf.setImage(with: URL(string: viewModel.ownerImageUrl))
    }
}


