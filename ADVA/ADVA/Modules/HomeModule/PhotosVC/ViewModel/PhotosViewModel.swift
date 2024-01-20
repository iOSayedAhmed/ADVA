//
//  PhotosViewModel.swift
//  ADVA
//
//  Created by iOSAYed on 20/01/2024.
//

import Foundation
import RxSwift
import RxRelay

protocol PhotosViewModelType {
    func getAllPhotos() async
    func loadPaginationPhotos(by limit:Int)
    func loadMorePhotos()
}

final class PhotosViewModel: PhotosViewModelType{
    
    private var networkService = NetworkService()
    
    //        init(networkService: NetworkService) {
    //            self.networkService = networkService
    //        }
    
    private var allPhotos: [PhotosResponseElement] = []
    private var currentPage = 1
    
    private let isLoadingBehavior:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    private let photoResponseBehaviorRelay:BehaviorRelay<PhotosResponse> = BehaviorRelay(value: [])
    
    var isLoadingObservable: Observable<Bool> {
        return isLoadingBehavior.asObservable()
    }
    
    var photoResponseObservable: Observable<PhotosResponse> {
        return photoResponseBehaviorRelay.asObservable()
    }
    func getAllPhotos() async {
        isLoadingBehavior.accept(true)
        do {
            let response: PhotosResponse = try await networkService.request(endpoint: .allPhotos, parameters: [:])
            allPhotos = response
            loadPaginationPhotos()
        } catch {
            print(error.localizedDescription)
        }
        
        isLoadingBehavior.accept(false)
    }
    
    func loadPaginationPhotos(by limit:Int = 20){
        let startIndex = (currentPage - 1) * limit
        let endIndex = min(startIndex + limit, allPhotos.count)
        let pagePhotos =  Array(allPhotos[startIndex..<endIndex])
        let existingPhotos = photoResponseBehaviorRelay.value
        photoResponseBehaviorRelay.accept(existingPhotos + pagePhotos)
    }
    
    func loadMorePhotos(){
        currentPage += 1
        loadPaginationPhotos()
    }
}
