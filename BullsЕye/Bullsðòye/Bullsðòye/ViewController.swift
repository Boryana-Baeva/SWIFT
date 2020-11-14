//
//  ViewController.swift
//  BullsЕye
//
//  Created by Veronica Velkova on 13.09.20.
//  Copyright © 2020 softuni-demo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetValueLabel: UILabel!
    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var currentRound: UILabel!
    @IBOutlet weak var hitMeButton: UIButton! {
        didSet {
            hitMeButton.layer.cornerRadius = 4.0
        }
    }
    
    
    
    // MARK: - Properties
    var currentSliderValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSlider()
        startNewGame()
    }
    
    // MARK: - Actions
    @IBAction func showAlert() {
        let result = calculateScore()
        score += result
        
        let title: String
        if result == 100 {
            title = "Perfect!"
            score += 100
        } else if result >= 95 {
            score = result == 99 ?
                score + 50 :
            score
            title = "You almost had it!"
        } else if result >= 90 {
            title = "Pretty good!"
        } else {
            title = "Not even close!"
        }
        
        let alert = UIAlertController(title: title, message: "You scored \(result)", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) {
            [weak self] _ in
            self?.determineSuitableAction()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        currentSliderValue = Int(sender.value.rounded())
    }
    
    @IBAction func startOver() {
        startNewGame()
    }
    
    // MARK: - Private members
    private func startNewRound() {
        currentSliderValue = 50
        round += 1
        slider.value = Float(currentSliderValue)
        targetValue = Int.random(in: 1...100)
        updateValues()
    }
    
    private func updateValues() {
        targetValueLabel.text = String(targetValue)
        currentScore.text = "\(score)"
        currentRound.text = "\(round)"
    }
    
    private func calculateScore() -> Int {
        let difference = abs(currentSliderValue - targetValue)
        return 100 - difference
    }
    
    private func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    private func setupSlider() {
        let thumbImageNormal = UIImage(named: "slider-bullseye-normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)

        let thumbImageHighlighted = UIImage(named: "slider-bullseye-selected")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
    }
    
    private func isLimitReached() -> Bool {
        let scoreLimit = 99_999
        let roundLimit = 999
        
        return score >= scoreLimit || round == roundLimit
        
    }
    
    private func determineSuitableAction() {
        isLimitReached() ? startNewGame() : startNewRound()
    }
}

