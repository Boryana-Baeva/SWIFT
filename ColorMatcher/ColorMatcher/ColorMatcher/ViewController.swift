//
//  ViewController.swift
//  ColorMatcher
//
//  Created by Boryana Baeva on 25/09/2020.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: -IBOutlets
    @IBOutlet weak var targetColorView: UIView!
    @IBOutlet weak var matchColorView: UIView!
    @IBOutlet weak var sliderRed: UISlider!
    @IBOutlet weak var sliderGreen: UISlider!
    @IBOutlet weak var sliderBlue: UISlider!
    @IBOutlet weak var matchColorLabel: UILabel!
    @IBOutlet weak var hitMeButton: UIButton!
    
    // MARK: -Properties
	var targetColor = (red: 0, green: 0, blue: 0)
    var matchColor = (red: 0, green: 0, blue: 0) {
        didSet {
            setMatchColor()
            updateMatchColorLabel()
        }
    }
    
    
    // MARK: -UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        resetColorMatcher()
    }

    // MARK: -Actions
    @IBAction func hitMe() {
        let matchAccuracy = calculateMatchAccuracy()
        let title: String

        switch matchAccuracy {
        case 255: title = "Perfect match!"
        case 240...254: title = "Close enough!"
        case 225...239: title = "Not bad!"
        default: title = "Not even close!"
        }
        
        let message = """

                    You had to match:
                    R: \(targetColor.red) G: \(targetColor.green) B: \(targetColor.blue)

                    You picked:
                    R: \(matchColor.red) G: \(matchColor.green) B: \(matchColor.blue)
                    """
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) {
            [weak self] _ in self?.resetColorMatcher()
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @IBAction func sliderRedMoved(_ sender: UISlider) {
        matchColor.red = Int(sender.value.rounded())
    }
    
    @IBAction func sliderGreenMoved(_ sender: UISlider){
        matchColor.green = Int(sender.value.rounded())
    }
    
    @IBAction func sliderBlueMoved(_ sender: UISlider) {
        matchColor.blue = Int(sender.value.rounded())
    }
    
    // MARK: -Private members
    private func resetColorMatcher() {
        resetSliderValues()
        setMatchColor()
        setTargetColor()
    }
    
    private func resetSliderValues() {
        matchColor = (red: 127, green: 127, blue: 127)
        
        sliderRed.value = Float(matchColor.red)
        sliderGreen.value = Float(matchColor.green)
        sliderBlue.value = Float(matchColor.blue)
    }
    
    private func setTargetColor(){
        targetColor.red = Int.random(in: 0...255)
        targetColor.green = Int.random(in: 0...255)
        targetColor.blue = Int.random(in: 0...255)
        
        targetColorView.backgroundColor = UIColor(red: targetColor.red,
												  green: targetColor.green,
												  blue: targetColor.blue)
    }
    
    private func setMatchColor() {
        matchColorView.backgroundColor = UIColor(red: matchColor.red,
                                      		     green: matchColor.green,
												 blue: matchColor.blue)
    }
    
    private func updateMatchColorLabel() {
        matchColorLabel.text = "R: \(matchColor.red) G: \(matchColor.green) B: \(matchColor.blue) "
    }
    
    private func calculateMatchAccuracy() -> Int {
        let differenceR = abs(targetColor.red - matchColor.red)
        let differenceG = abs(targetColor.green - matchColor.green)
        let differenceB = abs(targetColor.blue - matchColor.blue)
        
        let matchAccuracyR = 255 - differenceR
        let matchAccuracyG = 255 - differenceG
        let matchAccuracyB = 255 - differenceB
        
        return (matchAccuracyR + matchAccuracyG + matchAccuracyB) / 3
    }
}


