//
//  PhotoDetailsCoordinator.swift
//  ADVA
//
//  Created by iOSAYed on 21/01/2024.
//

import UIKit

final class PhotoDetailsCoordinator:Coordinator {
    
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController:UINavigationController
    
    var photoData:PhotosResponseElement
    init(navigationController:UINavigationController,photoData:PhotosResponseElement){
        self.navigationController = navigationController
        self.photoData = photoData
    }
    
    func start() {
        let photoDetailsViewModel = PhotoDetailsViewModel(coordinator: self,photoData: photoData)
        let photoDetailsVC = PhotoDetails(viewModel: photoDetailsViewModel, nibName: "\(PhotoDetails.self)")
        photoDetailsVC.photoData = photoData
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(photoDetailsVC, animated: true)
    }
}
