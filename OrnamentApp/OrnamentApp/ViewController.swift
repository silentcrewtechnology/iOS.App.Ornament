//
//  ViewController.swift
//  AbbDesignTestApp
//
//  Created by Алексей Титов on 30.10.2022.
//

import UIKit
import Ornament

class ViewController: UIViewController {

    let delegate = OnlyUppercasedTextFieldDelegate()
    
    lazy var input: BorderLabeledInput = {
        let input = BorderLabeledInput()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.textField.delegate = delegate
        return input
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let buttonHide = UIButton()
        buttonHide.translatesAutoresizingMaskIntoConstraints = false
        buttonHide.setTitle("TOP LABEL HIDE", for: .normal)
        buttonHide.setTitleColor(.red, for: .normal)
        buttonHide.addTarget(self, action: #selector(buttonHideTap), for: .touchUpInside)
        
        let buttonShow = UIButton()
        buttonShow.translatesAutoresizingMaskIntoConstraints = false
        buttonShow.setTitle("TOP LABEL SHOW", for: .normal)
        buttonShow.setTitleColor(.black, for: .normal)
        buttonShow.addTarget(self, action: #selector(buttonShowTap), for: .touchUpInside)
        
        input.textField.addTarget(
            delegate,
            action: #selector(OnlyUppercasedTextFieldDelegate.textChange),
            for: .editingChanged
        )
        
        let label = UILabel()
        label.text = "Prefix"
        label.sizeToFit()
        input.textField.rightView = label
        input.textField.contentMode = .center
        input.textField.rightViewMode = .always
        
        let icon = UIView()
        icon.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        icon.backgroundColor = .black
        
        input.textField.leftView = icon
        input.textField.leftViewMode = .always
        input.textField.text = "asdasdasdasdasdasdasdasdasd"

        input.topLabel.text = "Top Label"
        input.backgroundColor = .blue.withAlphaComponent(0.2)

        view.addSubview(input)
        view.addSubview(buttonHide)
        view.addSubview(buttonShow)
        
        NSLayoutConstraint.activate([
            input.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            input.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            input.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            input.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
            buttonHide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buttonHide.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonHide.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 1),
            buttonHide.heightAnchor.constraint(equalToConstant: 70),
            
            buttonShow.heightAnchor.constraint(equalToConstant: 70),
            buttonShow.bottomAnchor.constraint(equalTo: buttonHide.topAnchor, constant: -16),
            buttonShow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonShow.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 1)
            
        ])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func buttonHideTap() {
        input.hideTopLabel(animated: true)
    }
    
    @objc func buttonShowTap() {
        input.showTopLabel(animated: true)
    }

    @objc func endEditing() {
        view.endEditing(true)
    }
    
    
}
