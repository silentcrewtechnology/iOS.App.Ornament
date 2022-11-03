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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let textfield = BorderRoundedTextField()
        textfield.delegate = delegate
        textfield.addTarget(delegate, action: #selector(OnlyUppercasedTextFieldDelegate.textChange), for: .editingChanged)
        textfield.placeholder = "Test Placeholder Test Placeholder Test Placeholder Test Placeholder Test Placeholder"
        textfield.layer.cornerRadius = 8
        textfield.font = .systemFont(ofSize: 18)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textfield)
        
        NSLayoutConstraint.activate([
            textfield.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textfield.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            textfield.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16)
        ])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tap)
        
    }

    @objc func endEditing() {
        view.endEditing(true)
    }
    
    
}
