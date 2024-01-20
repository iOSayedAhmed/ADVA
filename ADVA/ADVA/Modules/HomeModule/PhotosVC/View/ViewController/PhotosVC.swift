//
//  HomeVC.swift
//  ADVA
//
//  Created by iOSAYed on 16/01/2024.
//

import UIKit
import RxSwift
import RxCocoa

class PhotosVC: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: - Propreties
    let viewModel = PhotosViewModel()
    private let disposeBag = DisposeBag()
    private var isLoadingMoreData = false
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        getAllPhotos()
        bindingViewModel()
        
    }
    
    
    //MARK: - Methods
    
    private func setupView(){
        self.title = "Photos"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .primary100
    }
    private func setupCollectionView(){
        collectionView.register(UINib(nibName: "\(PhotosCollotionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(PhotosCollotionViewCell.self)")
        collectionView.collectionViewLayout = CollectionViewLayouts.shared.createLayout()
        
        
        
    }
    
    private func getAllPhotos() {
        Task {
            await viewModel.getAllPhotos()
        }
    }
    
    private func bindingViewModel(){
        
        //bind Activity Indicator View
        viewModel.isLoadingObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] in
                guard let self else {return}
                $0 ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
            }).disposed(by: disposeBag)
        
        //bind Collection View
        viewModel.photoResponseObservable
            .observe(on: MainScheduler.instance)
            .bind(to: collectionView.rx.items(cellIdentifier: "\(PhotosCollotionViewCell.self)", cellType: PhotosCollotionViewCell.self)){ [weak self] index,model,cell in
                guard let self else {return}
                cell.setupPhotoCell(from: model)
                self.isLoadingMoreData = false
                self.activityIndicator.stopAnimating()
            }.disposed(by: disposeBag)
        
        //handle did select cell of collection view
        collectionView.rx.modelSelected(PhotosResponseElement.self)
            .subscribe(onNext: {  [weak self] model in
                guard let self else {return}
                print(model.title)
                goToIPhotoDetails(with: model)
            }).disposed(by: disposeBag)
        
        
        collectionView.rx.didEndDragging
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self else {return}
                let offsetY = collectionView.contentOffset.y
                let contentHeight = collectionView.contentSize.height
                let height = collectionView.frame.size.height
                
                if offsetY > contentHeight - height - 20 {
                    self.activityIndicator.startAnimating()
                    self.isLoadingMoreData = true
                    self.viewModel.loadMorePhotos()
                }
                
            })
            .disposed(by: disposeBag)
        
    }
    
    //Navigate to photo Details
    private func goToIPhotoDetails(with model:PhotosResponseElement){
        let photoDetails = PhotoDetails()
        photoDetails.photoData = model
        self.navigationController?.pushViewController(photoDetails, animated: true)
    }
    
}

