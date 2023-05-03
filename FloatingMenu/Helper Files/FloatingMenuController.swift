//
//  FloatingMenuController.swift
//  FloatingMenu
//
//  Created by K Rajeshwar on 20/04/23.
//

import UIKit

@objc
protocol FloatingMenuControllerDelegate: class {
    @objc optional func floatingMenuController(controller: FloatingMenuController, didTapOnButton button: UIButton, atIndex index: Int)
    @objc optional func floatingMenuControllerDidCancel(controller: FloatingMenuController)
}

class FloatingMenuController: UIViewController {

    let fromView: UIView
    let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
    let closeButton = FloatingButton(image: UIImage(named: "close"), backgroundColor: UIColor.flatRedColor)

    var buttonDirection = Direction.Up
    var buttonPadding: CGFloat = 70
    var buttonItems = [FloatingButton]()
    
    var delegate: FloatingMenuControllerDelegate?

    var labelDirection = Direction.Left
    var labelTitles = [String]()
    var buttonLabels = [UILabel]()
    
    // MARK: UIViewController

    init(fromView: UIView) {
        self.fromView = fromView
        super.init(nibName: nil, bundle: nil)

        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        blurredView.frame = view.bounds
        view.addSubview(blurredView)
        view.addSubview(closeButton)
        
        closeButton.addTarget(self, action: #selector(handleCloseMenu), for: .touchUpInside)
        view.addSubview(closeButton)
        
        for title in labelTitles {
            let label = UILabel()
            label.text = title
            label.textColor = UIColor.flatBlackColor
            label.textAlignment = .center
            label.font = UIFont(name: "HelveticaNeue-Light", size: 15)
            label.backgroundColor = UIColor.white
            label.sizeToFit()
            label.bounds.size.height += 25
            label.bounds.size.width += 32
            label.layer.cornerRadius = 20
            label.layer.masksToBounds = true
            view.addSubview(label)
            buttonLabels.append(label)
        }
        
        for (index, button) in buttonItems.enumerated() {
            button.tag = index
            button.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
            view.addSubview(button)
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateButtons(visible: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animateButtons(visible: false)
    }
    func configureButtons(initial: Bool) {
        let parentController = presentingViewController!
        let center = parentController.view.convert(fromView.center, from: fromView.superview)

        closeButton.center = center

        if initial {
            closeButton.alpha = 0
            closeButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))

            for (index, button) in buttonItems.enumerated() {
                button.center = center
                button.alpha = 0
                button.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                
                let label = buttonLabels[index]
                let buttonCenter = buttonDirection.offsetPoint(point: center, offset: buttonPadding * CGFloat(index+1))

                let labelSize = labelDirection == .Up || labelDirection == .Down ? label.bounds.height : label.bounds.width
                let labelCenter = labelDirection.offsetPoint(point: buttonCenter, offset: buttonPadding/2 + labelSize)
                label.center = labelCenter
                label.alpha = 0
            }
           // closeButton.layer.cornerRadius = 6
            
        }
        else {
            closeButton.alpha = 1
            closeButton.transform = CGAffineTransformIdentity

            for (index, button) in buttonItems.enumerated() {
                let label = buttonLabels[index]

                button.center = buttonDirection.offsetPoint(point: center, offset: buttonPadding * CGFloat(index+1))
                button.alpha = 1
                button.transform = CGAffineTransformIdentity
                
                let buttonCenter = buttonDirection.offsetPoint(point: center, offset: buttonPadding * CGFloat(index+1))

                let labelSize = labelDirection == .Up || labelDirection == .Down ? label.bounds.height : label.bounds.width
                let labelCenter = labelDirection.offsetPoint(point: buttonCenter, offset: buttonPadding - 12)
                label.center = labelCenter
                label.alpha = 1
                
            }
            closeButton.layer.cornerRadius = 6

        }
    }
    @objc func handleMenuButton(sender: UIButton) {
        delegate?.floatingMenuController?(controller: self, didTapOnButton: sender, atIndex: sender.tag)
    }
    @objc func handleCloseMenu(sender: AnyObject) {
        delegate?.floatingMenuControllerDidCancel?(controller: self)
        dismiss(animated: true, completion: nil);
    }
    func animateButtons(visible: Bool) {
        configureButtons(initial: visible)

        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .allowAnimatedContent, animations: { () -> Void in
            [ self ]
            self.configureButtons(initial: !visible)
        }, completion: nil)
    }
}
