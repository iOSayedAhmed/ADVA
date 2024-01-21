//
//  AlbumsVC.swift
//  ADVA
//
//  Created by iOSAYed on 16/01/2024.
//

import UIKit
import RxSwift
import RxCocoa

class AlbumsVC: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Propreties
    private let viewModel : AlbumsViewModel?
    private let disposeBag = DisposeBag()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        getAllAlbums()
        bindingViewModel()
    }
    
    
    init(viewModel:AlbumsViewModel,nibName:String) {
        self.viewModel = viewModel
        super.init(nibName: nibName, bundle: nil)
    }
    
    convenience required init() {
        let defaultViewModel = AlbumsViewModel()
        self.init(viewModel: defaultViewModel, nibName: "\(AlbumsVC.self)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    //MARK: - Methods
    private func setupView(){
        self.title = "Albums"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        activityIndicator.hidesWhenStopped = true
    }
    
    private func setupCollectionView(){
        
        collectionView.collectionViewLayout = CollectionViewLayouts.shared.createLayout()
        collectionView.register(UINib(nibName: "\(PhotosCollotionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(PhotosCollotionViewCell.self)")
    }
    
    private func getAllAlbums(){
        Task {
            await viewModel?.getAllAlbums()
        }
    }
    
    private func bindingViewModel(){
        viewModel?.isLoadingObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] in
                guard let self else {return}
                $0 ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
            }).disposed(by: disposeBag)
        
        viewModel?.albumeResponseObservable
            .observe(on: MainScheduler.instance)
            .bind(to: collectionView.rx.items(cellIdentifier: "\(PhotosCollotionViewCell.self)", cellType: PhotosCollotionViewCell.self)){ index,model,cell in
                cell.setupAlbumCell(from: model)
            }.disposed(by: disposeBag)
        
        
        
    }
 

}

