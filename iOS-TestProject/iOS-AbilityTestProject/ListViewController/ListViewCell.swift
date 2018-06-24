//
//  TableViewCell.swift
//  iOS-AbilityTestProject
//
//  Created by Ger on 2018/6/24.
//  Copyright © 2018年 Test.Ger.com. All rights reserved.
//

import UIKit
import Kingfisher

let ScreenWidth = UIScreen.main.bounds.size.width

class ListViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var describtion: UILabel!
    @IBOutlet weak var imageHrefView: UIImageView!
    
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var describtionLableWidth: NSLayoutConstraint!   //xib添加约束时图片和描述label等宽（可更改）
    
    weak var cellModel:ListViewRowModel? {
        willSet(newValue){
            
        }
        
        didSet{
            title.text = cellModel?.title
            describtion.text = cellModel?.description
            imageHrefView.kf.setImage(with: URL(string: (cellModel?.imageHref) ?? "default"), placeholder: UIImage(named: "default"))
            
            imageHrefView.kf.setImage(with: URL(string: (cellModel?.imageHref) ?? "default"), placeholder: UIImage(named: "default")) { (image, _, _, _) in
                //获取下载图片的宽高等
                // TO DO...
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UIImageView {
    
}


