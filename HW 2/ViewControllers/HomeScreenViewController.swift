//
//  HomeScreenViewController.swift
//  HW 2
//
//  Created by Кирилл Крамар on 05.06.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    //MARK: - Public Property
    var redColorValue: Float?
    var greenColorValue: Float?
    var blueColorValue: Float?
    
    //MARK: - NAvigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorSwitchingVC = segue.destination as? ColorSwitchingViewController else { return }
        colorSwitchingVC.delegate = self
        
        colorSwitchingVC.redColorValue   = redColorValue
        colorSwitchingVC.greenColorValue = greenColorValue
        colorSwitchingVC.blueColorValue  = blueColorValue
       
        
    }
}

//MARK: - ColorSwitchingViewControllerDelegate
extension HomeScreenViewController: ColorSwitchingViewControllerDelegate {
    func setColorValue(to redColorValue: Float, to greenColorValue: Float, to blueColorValue: Float) {
        self.redColorValue   = redColorValue
        self.greenColorValue = greenColorValue
        self.blueColorValue  = blueColorValue
        
        view.backgroundColor =  UIColor(red:   CGFloat(redColorValue) ,
                                        green: CGFloat(greenColorValue) ,
                                        blue:  CGFloat(blueColorValue)  ,
                                                   alpha: 1)
    }
}
