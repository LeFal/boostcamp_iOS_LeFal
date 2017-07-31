//
//  PhotosViewController.swift
//  Photorama
//
//  Created by LEOFALCON on 2017. 7. 30..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    var store : PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        store.fetchRecentPhoto() {
            (photosResult) -> Void in
            
            OperationQueue.main.addOperation(){
                switch photosResult {
                case let .success(photos) :
                    print("Successfully found \(photos.count) recent photos")
                    self.photoDataSource.photos = photos
                case let .failure(error) :
                    self.photoDataSource.photos.removeAll()
                    print("Error downloading image \(error)")
                }
                self.collectionView.reloadSections(IndexSet(integer:0))
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        store.fetchImageForPhoto(photo: photo) { (result) in
            OperationQueue.main.addOperation(){
                let photoIndex = self.photoDataSource.photos.index(of: photo)!
                let photoIndexPath = IndexPath(row: photoIndex, section: 0)
                
                if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                    cell.updateWithImage(image: photo.image)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
