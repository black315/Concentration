//
//  PlayingViewController.swift
//  Concentration
//

import UIKit

class PlayingViewController: UIViewController ,UICollectionViewDataSource,
UICollectionViewDelegate {
    
    let back: UIImage = UIImage(named: "back")!
    var cards = ["spade", "heart", "clover", "diamond", "spade", "heart", "clover", "diamond"]
    
    var selectedCell1: UIImageView = UIImageView(image: UIImage(named: "back"))
    var selectedCell2: UIImageView = UIImageView(image: UIImage(named: "back"))
    
    var selectedIndexPath1: IndexPath = IndexPath()
    var selectedIndexPath2: IndexPath = IndexPath()
    
    var counter: Int = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cards.shuffle()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell:UICollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        
        // let cellImage = UIImage(named: cards[indexPath.row])
        
        if counter == 0 {
            imageView.image = back
        } else if indexPath == selectedIndexPath1 {
            imageView.image = selectedCell1.image
        } else if indexPath == selectedIndexPath2 {
            imageView.image = selectedCell2.image
        } else {
            imageView.image = back
        }
        
        if counter % 2 == 0 {
            selectedCell1 = UIImageView(image: back)
            selectedCell2 = UIImageView(image: back)
        }
 
        return cell
    }
    
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        counter += 1
        
        if selectedCell1.image == back {
            selectedIndexPath1 = indexPath
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            selectedCell1 = cell.contentView.viewWithTag(1) as! UIImageView
            
            selectedCell1.image = UIImage(named: cards[indexPath.row])
            
            collectionView.reloadItems(at: [selectedIndexPath1])
        } else {
            selectedIndexPath2 = indexPath
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            selectedCell2 = cell.contentView.viewWithTag(1) as! UIImageView
            
            selectedCell2.image = UIImage(named: cards[indexPath.row])
            
            if selectedCell1.image == selectedCell2.image {
                collectionView.reloadItems(at: [selectedIndexPath2])
            } else {
                selectedCell1.image = back
                selectedCell2.image = back
                
                collectionView.reloadItems(at: [selectedIndexPath1])
                collectionView.reloadItems(at: [selectedIndexPath2])
            }
        }
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return cards.count;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
