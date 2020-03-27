//
//  IconViewController.swift
//  Do_Did_List
//
//  Created by 강민석 on 2020/03/25.
//  Copyright © 2020 MinseokKang. All rights reserved.
//

import UIKit

protocol IconViewControllerDelegate: NSObjectProtocol {
    func iconName(name: String)
}

class IconViewController: UIViewController {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var iconCollectionVIew: UICollectionView!
    
    weak var delegate: IconViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        isModalInPresentation = true
        
        setCollectionView()
        
    }
    
    func setCollectionView() {
        iconCollectionVIew.dataSource = self
        iconCollectionVIew.delegate = self
        
        iconCollectionVIew.showsHorizontalScrollIndicator = false
        iconCollectionVIew.allowsSelection = true
        iconCollectionVIew.allowsMultipleSelection = false
        
        if let layout = iconCollectionVIew.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            
            layout.itemSize = CGSize(width: 50, height: 50)
            
            layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        }
    }
    
    @IBAction func doneButton(_ sender: Any) {
        delegate?.iconName(name: "testing")
        isModalInPresentation = false
        dismiss(animated: true, completion: nil)
    }
    
}


// MARK: - UICollectionViewDataSource
extension IconViewController: UICollectionViewDataSource {

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
extension IconViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("#1", indexPath, #function)
        
        iconImageView.image = UIImage(named: "CategoryIcon")
        
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
