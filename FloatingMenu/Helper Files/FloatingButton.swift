//
//  FloatingButton.swift
//  FloatingMenu
//
//  Created by K Rajeshwar on 20/04/23.
//

import UIKit

class FloatingButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        tintColor = UIColor.flatWhiteColor
        if backgroundImage(for: .normal) == nil {
            setBackgroundImage(UIColor.white.pixelImage, for: .normal)
        }

        layer.cornerRadius = frame.width/2
        layer.masksToBounds = true
    }
    convenience init(image: UIImage?, backgroundColor: UIColor = UIColor.flatBlueColor) {
        self.init()
        self.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.setImage(image, for: .normal)
        
      //  setBackgroundImage(backgroundColor.pixelImage, for: .normal)
    }

}
