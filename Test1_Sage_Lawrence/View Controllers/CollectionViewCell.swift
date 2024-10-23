//
//  CollectionViewCell.swift
//  Test1_Sage_Lawrence
//
//  Created by Sage Lawrence on 2024-10-20.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Round corners
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Ensure rounding happens after layout
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
    }
    
}
