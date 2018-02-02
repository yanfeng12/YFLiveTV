//
//  DiscoveryCell.swift
//  YFLiveTV
//
//  Created by guopenglai on 2018/1/31.
//  Copyright © 2018年 guopenglai. All rights reserved.
//

import UIKit

class DiscoveryCell: UICollectionViewCell {

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var liveImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    var discoveryModel:DiscoveryModel?{
        didSet{
            albumImageView.setImage(discoveryModel!.isEvenIndex! ? discoveryModel?.pic74 : discoveryModel?.pic51, "home_pic_default")
            liveImageView.isHidden = discoveryModel?.live == 0
            nameLabel.text = discoveryModel?.name
            countBtn.setTitle("\(discoveryModel?.focus ?? 0)", for: .normal)
        }
    }
    

}
