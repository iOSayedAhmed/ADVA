//
//  AlbumsViewModel.swift
//  ADVA
//
//  Created by iOSAYed on 20/01/2024.
//

import Foundation
import RxSwift
import RxRelay

protocol AlbumsViewModelType {
    func getAllAlbums() async
}

final class AlbumsViewModel: AlbumsViewModelType{
   
    private var networkService = NetworkService()
    
//        init(networkService: NetworkService) {
//            self.networkService = networkService
//        }
    
    private let isLoadingBehavior:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    
    var isLoadingObservable: Observable<Bool> {
        return isLoadingBehavior.asObservable()
    }
    
   func getAllAlbums() async {
        isLoadingBehavior.accept(true)
        do {
            let response: AlbumsResponse = try await networkService.request(endpoint: .allAlbums, parameters: [:])
           
           // responseBehaviorRelay.accept(response)
           // allCategoriesBehaviorRelay.accept(response)
        } catch {
            print(error.localizedDescription)
        }

        isLoadingBehavior.accept(false)
    }
}
