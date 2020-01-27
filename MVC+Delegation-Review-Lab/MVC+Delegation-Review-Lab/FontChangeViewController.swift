//
//  FontChangeViewController.swift
//  MVC+Delegation-Review-Lab
//
//  Created by Lilia Yudina on 11/20/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

protocol FontSize: AnyObject {
    func changeFontSize(_ size: CGFloat)
}

class FontChangeViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var fontChangeLabel: UILabel!
    @IBOutlet weak var sliderControl: UISlider!
    @IBOutlet weak var stepperControl: UIStepper!
   
    
    var movie: Movie?
    weak var delegate: FontSize?
    
    var fontSize: CGFloat = 13.0 {
        didSet {
        fontChangeLabel.text = "Preview font size: \(fontSize)"
            delegate?.changeFontSize(fontSize)
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSlider()
        configureStepper()
        fontChangeLabel.text = "Preview font size: \(fontSize)"
    }
    
    
    func configureStepper() {
        stepperControl.maximumValue = 35.0
        stepperControl.minimumValue = 10.0
        stepperControl.stepValue = 1.0
        stepperControl.value = 13.0
    }
    func configureSlider() {
        sliderControl.maximumValue = 35.0
        sliderControl.minimumValue = 10.0
        sliderControl.value = 13.0
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    @IBAction func stepperChanged(_ sender: UIStepper) {
        fontSize = CGFloat(sender.value)
    sliderControl.value = Float(stepperControl.value)

    }
    @IBAction func sliderChanged(_ sender: UISlider) {
        fontSize = CGFloat(sender.value)
        stepperControl.value = Double(sliderControl.value)
    }

}

