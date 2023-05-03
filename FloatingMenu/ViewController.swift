//
//  ViewController.swift
//  FloatingMenu
//
//  Created by K Rajeshwar on 20/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        menuBtn.layer.cornerRadius = 6
    }

    @IBAction func handleMenuButton(sender: AnyObject) {
        let controller = FloatingMenuController(fromView: sender as! UIButton)
        controller.buttonItems = [
            FloatingButton(image: UIImage(named: "facebook")),
            FloatingButton(image: UIImage(named: "instagram")),
            FloatingButton(image: UIImage(named: "linkedin")),
            FloatingButton(image: UIImage(named: "twitter")),
        ]
        controller.labelTitles = [
            "Facebook         ",
            "Instagram        ",
            "LinkedIn         ",
            "Twitter          "
        ]
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
}

extension ViewController: FloatingMenuControllerDelegate {

    // MARK: FloatingMenuControllerDelegate

    func floatingMenuController(controller: FloatingMenuController, didTapOnButton button: UIButton, atIndex index: Int) {
        print("tapped index \(index)")
        controller.dismiss(animated: true, completion: nil)
    }
}
