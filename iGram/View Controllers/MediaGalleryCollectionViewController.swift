//
//  MediaGalleryCollectionViewController.swift
//  iGram
//
//  Created by Daniel Bolivar herrera on 2/10/17.
//  Copyright © 2017 iGenius. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SDWebImage

class MediaGalleryCollectionViewController: UICollectionViewController, NVActivityIndicatorViewable {

    var media = [IGMedia]() {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NVActivityIndicatorView.DEFAULT_TYPE = .pacman
        startAnimating()
        
        //Request user info
        IGNetworkManager.sharedInstance.retrieveSelfUserInfo(completion: { igUser in
            if let user = igUser {
                self.navigationItem.title = user.userName.capitalized
            }
            self.stopLoadingSpinner()
        })
        
        IGNetworkManager.sharedInstance.getRecentMediaForUser(completion: { mediaObjects in
            if let mediaArray = mediaObjects {
                self.media = mediaArray
            }
            self.stopLoadingSpinner()
        })
    }
    
    func stopLoadingSpinner() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            //Pacman loading animation is really cool to watch :D
            self.stopAnimating()
        }
    }
    
    func presentLoginVc() {
        
        let storyboard = R.storyboard.main()
        let vc = storyboard.instantiateViewController(withIdentifier: R.storyboard.main.igLoginVC.identifier) as! IGLoginViewController
        self.present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.media.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.mediaCellId.identifier, for: indexPath) as! MediaCollectionViewCell
        
        let mediaItem = media[indexPath.row]
        
        cell.activityIndicator.startAnimating()
        cell.thumbnail.image = nil
        
        guard let imageUrl = URL(string: mediaItem.thumbnailUrl) else { return cell }
        
        cell.thumbnail.sd_setImage(with: imageUrl, completed: { (image, error, cacheType, imageURL) in
            cell.activityIndicator.stopAnimating()
        })

        return cell
    }

}
