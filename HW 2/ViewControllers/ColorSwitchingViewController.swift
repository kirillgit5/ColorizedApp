//
//  ViewController.swift
//  HW 2
//
//  Created by Alexey Efimov on 12.06.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit

class ColorSwitchingViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    
    @IBOutlet var redColorTextField: UITextField!
    @IBOutlet var greenColorTextField: UITextField!
    @IBOutlet var blueColorTextField: UITextField!
    
    //MARK: Public Property
    var delegate: ColorSwitchingViewControllerDelegate!
    var redColorValue: Float?
    var greenColorValue: Float?
    var blueColorValue: Float?
    
    //MARK: Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        setupSliders()
        setColor()
        setValue(for: redLabel, greenLabel, blueLabel)
        setupTextFields()
        
    }
    
    //MARK: - Override Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IBAction
    @IBAction func goBack() {
        delegate.setColorValue(to: redSlider.value , to: greenSlider.value , to: blueSlider.value)
        dismiss(animated: true)
    }
    
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            redLabel.text          = string(from: sender)
            redColorTextField.text = string(from: sender)
        case 1:
            greenLabel.text          = string(from: sender)
            greenColorTextField.text = string(from: sender)
        case 2:
            blueLabel.text = string(from: sender)
            blueColorTextField.text  = string(from: sender)
        default: break
        }
        
        setColor()
    }
    
    //MARK: Private Methods
    private func setupTextFields() {
        redColorTextField.delegate   = self
        greenColorTextField.delegate = self
        blueColorTextField.delegate  = self
        
        redColorTextField.keyboardType   = .decimalPad
        greenColorTextField.keyboardType = .decimalPad
        blueColorTextField.keyboardType  = .decimalPad
        
        redColorTextField.text   = string(from: redSlider)
        greenColorTextField.text = string(from: greenSlider)
        blueColorTextField.text  = string(from: blueSlider)
        
        let bar = UIToolbar()
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneColorValue))
        bar.items = [flexible,done]
        bar.sizeToFit()
        
        redColorTextField.inputAccessoryView   = bar
        greenColorTextField.inputAccessoryView = bar
        blueColorTextField.inputAccessoryView  = bar
    }
    
    private func setupSliders() {
        redSlider.tintColor = .red
        greenSlider.tintColor = .green
        
        guard let redColorValue   = redColorValue,
              let greenColorValue = greenColorValue,
              let blueColorValue  = blueColorValue else { return }
        
        redSlider.value   = redColorValue
        greenSlider.value = greenColorValue
        blueSlider.value  = blueColorValue
        
    }
    
    private func setColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label.tag {
            case 0: redLabel.text = string(from: redSlider)
            case 1: greenLabel.text = string(from: greenSlider)
            case 2: blueLabel.text = string(from: blueSlider)
            default: break
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    private func float(from textField: UITextField) -> Float? {
        guard let text = textField.text else { return nil }
        return  Float(text)
    }
    
    // MARK: - Selectors
    @objc func doneColorValue() {
        view.endEditing(true)
   }
}

//MARK: - TextField Delegate
extension ColorSwitchingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
     guard let someColorValue = float(from: textField) ,
        (0.0...1.0).contains(Double(someColorValue)) else { return }
        switch textField.tag {
        case 0:
            redSlider.value   = someColorValue
            redLabel.text     = string(from: redSlider)
        case 1:
            greenSlider.value = someColorValue
            greenLabel.text   = string(from: greenSlider)
        case 2:
            blueSlider.value  = someColorValue
            blueLabel.text    = string(from: blueSlider)
        default:
            break
        }
        setColor()
    }
}

// MARK: - ColorSwitchingViewControllerDelegate
protocol  ColorSwitchingViewControllerDelegate {
    func setColorValue(to redColorValue: Float, to greenColorValue: Float, to blueColorValue: Float)
}
