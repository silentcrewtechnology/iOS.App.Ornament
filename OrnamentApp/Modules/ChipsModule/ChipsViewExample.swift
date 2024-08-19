
// TODO Восстановить chipsView

////
////  ChipsViewExampleVC.swift
////  OrnamentApp
////
////  Created by user on 30.07.2024.
////
//
//import UIKit
//import SnapKit
//import Components
//import ImagesService
//import DesignSystem
//
//private final class ChipsViewExampleVC: UIViewController {
//    
//    // MARK: - Private properties
//    
//    private var styles: [[ChipsViewStyle]] = [
//        (0..<4).map { _ in .init(selection: .default, state: .default, size: .large) },
//        (0..<4).map { _ in .init(selection: .default, state: .pressed, size: .large) },
//        (0..<4).map { _ in .init(selection: .default, state: .disabled, size: .large) },
//        (0..<4).map { _ in .init(selection: .selected, state: .default, size: .small) },
//        (0..<4).map { _ in .init(selection: .selected, state: .pressed, size: .small) },
//        (0..<4).map { _ in .init(selection: .selected, state: .disabled, size: .small) }
//    ]
//    private var updaters: [ChipsViewUpdater] = []
//    
//    // MARK: - Life cycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let vStack = vStack()
//        
//        for (i, row) in styles.enumerated() {
//            let hStack = hStack()
//            for j in row.indices {
//                let view = ChipsView()
//                hStack.addArrangedSubview(view)
//                let viewProperties = ChipsView.ViewProperties(
//                    leftView: j == 1 || j == 3 ? leftIconView() : nil,
//                    text: {
//                        if j == 0 {
//                            return "\(i) + \(j)".attributed
//                        } else if j == 1 {
//                            return "\(i)".attributed
//                        } else if j == 2 {
//                            return "\(j)".attributed
//                        } else {
//                            return "+".attributed
//                        }
//                    }(),
//                    rightView: j == 2 || j == 3 ? rightIconView() : nil)
//                let updater = ChipsViewUpdater(
//                    view: view,
//                    viewProperties: viewProperties,
//                    style: styles[i][j],
//                    onActive: { print("active \(i) + \(j)") },
//                    onInactive: { print("inactive \(i) + \(j)") }
//                )
//                updaters.append(updater)
//            }
//            vStack.addArrangedSubview(hStack)
//        }
//        
//        view.addSubview(vStack)
//        vStack.snp.makeConstraints {
//            $0.center.equalToSuperview()
//        }
//    }
//    
//    // MARK: - Private methods
//    
//    private func leftIconView() -> UIImageView {
//        let view = UIImageView(image: .ic16Tick)
//        
//        return view
//    }
//    
//    private func rightIconView() -> UIImageView {
//        let view = UIImageView(image: .ic16Close)
//        view.isUserInteractionEnabled = true
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightIconTapped)))
//        
//        return view
//    }
//    
//    private func vStack() -> UIStackView {
//        let stack = UIStackView()
//        stack.axis = .vertical
//        stack.spacing = 16
//        stack.alignment = .center
//        
//        return stack
//    }
//    
//    private func hStack() -> UIStackView {
//        let stack = UIStackView()
//        stack.axis = .horizontal
//        stack.spacing = 8
//        stack.alignment = .center
//        
//        return stack
//    }
//    
//    @objc private func rightIconTapped() {
//        print("right icon tapped")
//    }
//}
