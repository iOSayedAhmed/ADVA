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
    
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = SplachViewModel()
        self.viewModel = viewModel
        animateImageView()
        bindingViewModel()
    }
    
    //MARK: - methods
    
     func animateImageView() {
         guard let imageView = logoImageView else {
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
            isCompleted ? goToHome() : print("The animation is not complete yet!")
            
        }).disposed(by: disposeBag)
    }
    
    
    private func goToHome(){
        let home = MainTabBarController()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let delegate = windowScene.delegate as? SceneDelegate {
            let windows = delegate.window?.windowScene
            let navigationController = UINavigationController(rootViewController: home)
            navigationController.navigationBar.isHidden = true
            navigationController.navigationBar.isTranslucent = true
            windows?.keyWindow?.rootViewController = navigationController
            windows?.keyWindow?.makeKeyAndVisible()
        }
    }
    
}
