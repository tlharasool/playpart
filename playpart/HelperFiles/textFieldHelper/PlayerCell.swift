//
//  PlayerCell.swift
//  playpart
//
//  Created by talha on 07/10/2021.
//

import UIKit

class PlayerCell: UICollectionViewCell {
    var data:VideoData? {
        didSet {
         //   self.imgView.image = data?.image
          //  self.labTitle.text = data?.title
        }
    }
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var labTitle: UILabel!
    override func prepareForReuse() {
        super.prepareForReuse()
       // self.imgView.isHidden = false
        data = nil
    }
}
