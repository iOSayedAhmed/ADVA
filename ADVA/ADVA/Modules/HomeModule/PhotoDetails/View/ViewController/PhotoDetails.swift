//
//  PhotoDetails.swift
//  ADVA
//
//  Created by iOSAYed on 20/01/2024.
//

import UIKit

class PhotoDetails: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    //MARK: - Propreties
     var photoData : PhotosResponseElement?
    private let viewModel:PhotoDetailsViewModel?
    
    init(viewModel:PhotoDetailsViewModel,nibName:String) {
        self.viewModel = viewModel
        super.init(nibName: nibName, bundle: nil)
    }
    
    convenience required init() {
        let defaultViewModel = PhotoDetailsViewModel(photoData:nil)
        self.init(viewModel: defaultViewModel, nibName: "\(PhotoDetails.self)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupImageView()
        // Setup tap gesture
        setupTabGesture()

    }

    
    
    // MARK: - Methods

    private func setupView(){
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0

    }
    
  private func setupImageView(){
      guard let photoURL = photoData?.url else {return}
      imageView.setImageWithLoading(url: photoURL)
  }
    
    private func setupTabGesture(){
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(doubleTapRecognizer)
    }
    
    @objc private func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(4, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }


}

 extension PhotoDetails: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

