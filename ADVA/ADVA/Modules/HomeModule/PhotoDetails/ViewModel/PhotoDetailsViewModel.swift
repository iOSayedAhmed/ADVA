//
//  PhotoDetailsViewModel.swift
//  ADVA
//
//  Created by iOSAYed on 21/01/2024.
//

import Foundation

protocol PhotoDetailsViewModelType{
    
}

final class PhotoDetailsViewModel {
    
    weak var coordinator:PhotoDetailsCoordinator?
    var photoData:PhotosResponseElement?
    
    init(coordinator: PhotoDetailsCoordinator? = nil,photoData:PhotosResponseElement? ) {
        self.coordinator = coordinator
        self.photoData = photoData
    }
    
}

