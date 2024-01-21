//
//  PhotosCoordinator.swift
//  ADVA
//
//  Created by iOSAYed on 21/01/2024.
//

import UIKit

final class PhotosCoordinator:Coordinator {
    
    
    private(set) var childCoordinators: [Coordinator] = []
    
     let navigationController:UINavigationController
    
    init(navigationController:UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let photosViewModel = PhotosViewModel()
        photosViewModel.coordinator = self
        let photosVC = PhotosVC(viewModel: photosViewModel, nibName: "\(PhotosVC.self)")
        navigationController.setViewControllers([photosVC], animated: true)
    }
    
    func startPhotoDetails(photoData:PhotosResponseElement){
        let photoDetailsCoordinator = PhotoDetailsCoordinator(navigationController: navigationController, photoData: photoData)
        photoDetailsCoordinator.start()
    }
}
