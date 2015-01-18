//
//  BlogPostTableViewCell.swift
//  simpleblogtutorial
//
//  Created by Michael Peterson on 1/17/15.
//  Copyright (c) 2015 Michael Peterson. All rights reserved.
//

import UIKit

class BlogPostTableViewCell: UITableViewCell {

    @IBOutlet weak var IconLabel: UILabel!
    @IBOutlet weak var IconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
    }

    required init(coder aDecoder: NSCoder) {
       // fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func initialize()
    {
        self.IconLabel = UILabel()
        self.IconImage = UIImageView()
        self.titleLabel = UILabel()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
