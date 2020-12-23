//
//  EmptyBackgroundView.swift
//  MovieApp


import UIKit

class EmptyBackgroundView: UIView {

    @IBOutlet weak var descriptionImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func config(img: UIImage, description: String) {
        descriptionImageView.image = img
        descriptionLabel.text = description
    }
    
    private func setup() {
        let view = Bundle.main.loadNibNamed("\(Self.self)", owner: self, options: nil)?.first as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(view)
    }

}
