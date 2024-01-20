//
//  AlbumsVC.swift
//  ADVA
//
//  Created by iOSAYed on 16/01/2024.
//

import UIKit

class AlbumsVC: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Propreties
    let viewModel = AlbumsViewModel()
    
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
    }


    //MARK: - Methods
    private func setupView(){
        self.title = "Albums"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = CollectionViewLayouts.shared.createLayout()
        collectionView.register(UINib(nibName: "\(PhotosCollotionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(PhotosCollotionViewCell.self)")
        
    }
    
 

}

extension AlbumsVC:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PhotosCollotionViewCell.self)", for: indexPath) as? PhotosCollotionViewCell else {return UICollectionViewCell()}
        if indexPath.item % 2 == 0 {
            cell.setupAlbumCell(text: "culpa odio esse rerum omnis laboriosam voluptate repudiandae")
        }else {
            cell.setupAlbumCell(text: "culpa odio esse rerum")
        }
       
        return cell
    }
    

}

