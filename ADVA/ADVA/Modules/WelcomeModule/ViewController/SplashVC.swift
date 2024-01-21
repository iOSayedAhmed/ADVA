//
//  SplachVC.swift
//  ADVA
//
//  Created by iOSAYed on 16/01/2024.
//

import UIKit
import RxSwift
import RxCocoa

class SplashVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var logoImageView: UIImageView!
    
    
    //MARK: - Propreties
    var viewModel : SplachViewModelType!
    private let disposeBag = DisposeBag()
    
    
    
    init(viewModel:SplachViewModelType,nibName:String) {
        self.viewModel = viewModel
        super.init(nibName: nibName, bundle: nil)
    }
    
    convenience required init() {
        let defaultViewModel = PhotoDetailsViewModel(photoData:nil)
        self.init(viewModel: defaultViewModel as! SplachViewModelType, nibName: "\(SplashVC.self)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        animateImageView()
        bindingViewModel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.didDisAppear()
    }
    
    deinit {
        print(" SplashVC Deallocted")
    }
    
    
    //MARK: - methods
    
     func animateImageView() {
         guard  logoImageView != nil else {
                print("Error: logoImageView is nil")
                return
            }
        logoImageView.alpha = 0
        logoImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 2.0, animations: {
            self.logoImageView.alpha = 1
            self.logoImageView.transform = CGAffineTransform.identity
        }) { [weak self] _ in
            self?.viewModel.animationDidFinish()
        }
    }
    
    private func bindingViewModel(){
        guard let viewModel = viewModel else {
                print("Error: viewModel is nil")
                return
            }
        viewModel.animationCompleted.subscribe(onNext: {[weak self] isCompleted in
            guard let self else {return}
            isCompleted ? viewModel.goToMainTabBar() : print("The animation is not complete yet!")
            
        }).disposed(by: disposeBag)
    }
    
    

    
}
