//
//  KnobViewController.swift
//  iosLibrary
//
//  Created by Lim Thean Khoon on 16/08/2019.
//  Copyright © 2019 Lim Thean Khoon. All rights reserved.
//

import UIKit
import KnobControl

class KnobViewController: UIViewController {
    let knob: Knob = {
        let view = Knob(frame: CGRect(x: 8, y: 8, width: 150, height: 150))
        view.contentMode = UIView.ContentMode.scaleToFill
        view.autoresizesSubviews = true
        return view
    }()
    
    let valueLabel: UILabel = {
        let view = UILabel()
        view.text = "0"
        view.font = UIFont.systemFont(ofSize: 50)
        return view
    }()
    
    let valueSlider: UISlider = {
        let view = UISlider()
        return view
    }()
    
    let animateSwitch: UISwitch = {
        let view = UISwitch()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        knob.lineWidth = 4
        knob.pointerLength = 12
        knob.setValue(0)
        
        knob.addTarget(self, action: #selector(handleValueChanged(_:)), for: .valueChanged)
        valueSlider.addTarget(self, action: #selector(handleValueChanged(_:)), for: .valueChanged)

        view.addSubview(knob)
        view.addSubview(valueLabel)
        view.addSubview(valueSlider)
        view.addSubview(animateSwitch)
        knob.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueSlider.translatesAutoresizingMaskIntoConstraints = false
        animateSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            knob.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            knob.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            knob.widthAnchor.constraint(equalToConstant: 150),
            knob.heightAnchor.constraint(equalTo: knob.widthAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: knob.trailingAnchor, constant: 8),
            valueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            valueLabel.bottomAnchor.constraint(equalTo: knob.bottomAnchor),
            valueSlider.leadingAnchor.constraint(equalTo: knob.leadingAnchor, constant: 8),
            valueSlider.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor, constant: -8),
            valueSlider.topAnchor.constraint(equalTo: knob.bottomAnchor, constant: 8),
            valueSlider.heightAnchor.constraint(equalToConstant: 10),
            ])
        updateLabel()
    }
    
    @objc func handleValueChanged(_ sender: Any) {
        if sender is UISlider {
            knob.setValue(valueSlider.value)
        } else {
            valueSlider.value = knob.value
        }
        updateLabel()
    }
    
    private func updateLabel() {
        valueLabel.text = String(format: "%.2f", knob.value)
    }
}
