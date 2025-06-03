//
//  CutDownButton.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/13.
//

import UIKit

class CutDownButton: UIButton {
    private var timer: Timer?
    private var duration: Int = 60
    private var isCountingDown = false
    private var completion: (() -> Void)?
    
    var model: Model = .init() {
        didSet{
            applyModel()
        }
    }
    
    func startCountdown(completion: (() -> Void)? = nil){
        guard !isCountingDown else {return}
        self.completion = completion
        isCountingDown = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] timer in
            self?.duration -= 1
            self?.updateButtonTitle()
            if self?.duration == 0{
                self?.timer?.invalidate()
                self?.timer = nil
                self?.isCountingDown = false
                self?.completion?()
                self?.resetButton()
            }
        })
        updateButtonTitle()
    }
    
    private func resetButton(){
        duration = model.duration
        updateButtonTitle()
    }
    
    private func updateButtonTitle(){
        if isCountingDown{
            setTitle("\(duration)s", for: .normal)
        }else{
            setTitle(model.title, for: .normal)
        }
    }
    
    private func applyModel(){
        resetButton()
    }
}

extension CutDownButton{
    struct Model {
        var title: String = "Acquire"
        var duration: Int = 60
    }
}
