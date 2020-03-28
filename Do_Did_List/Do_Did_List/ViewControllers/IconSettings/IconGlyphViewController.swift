//
//  IconGlyphViewController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/03/27.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit

class IconGlyphViewController: UIViewController {

    @IBOutlet weak var glyphCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
    }
    
    
    func setCollectionView() {
        glyphCollectionView.dataSource = self
        glyphCollectionView.delegate = self
        
        glyphCollectionView.showsHorizontalScrollIndicator = false
        glyphCollectionView.allowsSelection = true
        glyphCollectionView.allowsMultipleSelection = false
        
        if let layout = glyphCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            
            layout.itemSize = CGSize(width: 50, height: 50)
            
            layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        }
    }

}


// MARK: - UICollectionViewDataSource
extension IconGlyphViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let icon = cell.contentView.viewWithTag(100) as? UIImageView {
            icon.image = UIImage(named: "CategoryIcon")
        }
        
        cell.contentView.layer.cornerRadius = 10
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension IconGlyphViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("#1", indexPath, #function)
        
//        iconImageView.image = UIImage(named: "CategoryIcon")
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = UIColor.systemGray4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        print("#2", indexPath, #function)
        
        guard let list = collectionView.indexPathsForSelectedItems else { return true }
        
        return !list.contains(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = nil
        }
    }
    
}
