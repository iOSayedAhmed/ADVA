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
    weak var coordinator:AlbumsCoordinator?
        init(coordinator: AlbumsCoordinator? = nil) {
            self.coordinator = coordinator
        }
    
    private let isLoadingBehavior:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    private let albumeResponseBehaviorRelay:BehaviorRelay<AlbumsResponse> = BehaviorRelay(value: [])
    
    var isLoadingObservable: Observable<Bool> {
        return isLoadingBehavior.asObservable()
    }
    
    var albumeResponseObservable: Observable<AlbumsResponse> {
        return albumeResponseBehaviorRelay.asObservable()
    }
    
    
   func getAllAlbums() async {
        isLoadingBehavior.accept(true)
        do {
            let response: AlbumsResponse = try await networkService.request(endpoint: .allAlbums, parameters: [:])
            response.forEach { item in
                print(item)
            }
            albumeResponseBehaviorRelay.accept(response)
        } catch {
            print(error.localizedDescription)
        }

        isLoadingBehavior.accept(false)
    }
}
