//
//  CustomImageFlowLayout.swift
//  Songol-E
//
//  Created by 최민섭 on 2018. 10. 17..
//  Copyright © 2018년 최민섭. All rights reserved.
//

import UIKit

class CustomImageFlowLayout : UICollectionViewFlowLayout{
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        setupLayout()
    }
    
    func setupLayout(){
        minimumLineSpacing = 8
        
        minimumInteritemSpacing = 1
        
        //scrollDirection = .vertical
    }
    
    override var itemSize: CGSize{
        set{
            
        }get{
            let numberOfColumns: CGFloat = 4.5
            
            let itemWidth = (self.collectionView!.frame.width - (numberOfColumns - 1)) / numberOfColumns - 1
            return CGSize(width: itemWidth, height: itemWidth)
        }
        
    }
    
}

