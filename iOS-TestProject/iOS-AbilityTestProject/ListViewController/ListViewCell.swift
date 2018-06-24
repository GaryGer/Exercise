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
    @IBOutlet weak var imgHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHrefView: UIImageView!
    fileprivate lazy var kingFisherManager:KingfisherManager = {
        let manager = KingfisherManager.shared
        return manager
    }()
    fileprivate var exsiteImage:Bool = false
    weak var cellModel:ListViewRowModel? {
        willSet(newValue){
           let image = kingFisherManager.cache.retrieveImageInDiskCache(forKey: (newValue?.imageHref ?? ""))
            
            if image != nil {
                imgHeightConstraint.constant = ((image?.size.height ?? 0)/(image?.size.width ?? 1)) * imageHrefView.frame.width
            }else if image == nil && newValue?.imageHref != nil {
                imgHeightConstraint.constant = (ScreenWidth - 25)/2
            }else{
                imgHeightConstraint.constant = 0
            }
            self.imageHrefView.layoutIfNeeded()
        }
        didSet{
            title.text = cellModel?.title
            describtion.text = cellModel?.description
            imageHrefView.kf.setImage(with: URL(string: (cellModel?.imageHref) ?? "default"), placeholder: UIImage(named: "default"))
            imageHrefView.isHidden = (cellModel?.imageHref == nil)
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

