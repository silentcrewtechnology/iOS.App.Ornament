//  SectionMessageViewController.swift
//  OrnamentApp
//
//  Created by Валерий Васин on 20.12.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit
import Architecture
import DesignSystem
import Components

final class ChoosingStyleButtonView: UIButton {
    
    let label = UILabel()
    
    init() {
        super.init(frame: .zero)
        configureViews()
        setupSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        backgroundColor = .systemGray
        layer.cornerRadius = 4
        label.textColor = .black
        label.font = UIFont.textM
    }
    
    private func setupSubview() {
        addSubview(label)
        label.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(16)
            $0.right.bottom.equalToSuperview().offset(-16)
            $0.height.equalTo(16)
        }
    }
}

final class SectionMessageViewController: ViewController<SectionMessageFeature>, ViewProtocol {
    
    deinit {
        print("💀 удалился SectionMessageScreenController")
    }
    
    struct ViewProperties {
        var accessibilityId = "SectionMessageScreenController"
        var sectionMessageProperties: SectionMessageView.ViewProperties = .init()
        var title = "Компонент SectionMessage"
        var styleButtonsAction: (Int) -> Void
        // Здесь описываются свойства вью
        // нужно заменить SomeView на твою View
    }
    
    enum State {
        case create(SectionMessageStyle, ViewProperties?)
        case newState(SectionMessageStyle, ViewProperties)
        // Здесь описываются состояния вью
    }
    
    // Здесь хранятся свойства вью, чтобы вызывать экшены
    var viewProperties: ViewProperties?
    
    // Ниже создаем внутренние вью элементы
    // MARK: UI Elements
    
    var sectionMessageView: SectionMessageView?
    var infoButton = ChoosingStyleButtonView()
    var warningButton = ChoosingStyleButtonView()
    var successButton = ChoosingStyleButtonView()
    var errorButton = ChoosingStyleButtonView()
    var securityButton = ChoosingStyleButtonView()
    var noneButton = ChoosingStyleButtonView()
    
    // нужно заменить SomeView на твою View
    // var someView: SomeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupSubview()
    }
    
    // Ниже функции от ViewProtocol'а
    // MARK: ViewProtocol
    
    func update(viewProperties: ViewProperties?) {
        guard let viewProperties else { return }
        self.viewProperties = viewProperties
        view.accessibilityIdentifier = viewProperties.accessibilityId
        sectionMessageView?.update(with: viewProperties.sectionMessageProperties)
        // Здесь обновляем все свойства вью
    }
    
    // MARK: Private funcs
    
    private func configureViews() {
        // Здесь настраиваем внутренние свойства - то, что не будет меняться
        
        view.backgroundColor = .white
        
        infoButton.tag = 1
        infoButton.label.text = "state info"
        infoButton.addTarget(self, action: #selector(buttonsAction), for: .touchUpInside)
        warningButton.tag = 2
        warningButton.label.text = "state warning"
        warningButton.addTarget(self, action: #selector(buttonsAction), for: .touchUpInside)
        successButton.tag = 3
        successButton.label.text = "state success"
        successButton.addTarget(self, action: #selector(buttonsAction), for: .touchUpInside)
        errorButton.tag = 4
        errorButton.label.text = "state error"
        errorButton.addTarget(self, action: #selector(buttonsAction), for: .touchUpInside)
        securityButton.tag = 5
        securityButton.label.text = "state security"
        securityButton.addTarget(self, action: #selector(buttonsAction), for: .touchUpInside)
        noneButton.tag = 6
        noneButton.label.text = "state none"
        noneButton.addTarget(self, action: #selector(buttonsAction), for: .touchUpInside)
    }
    
    @objc private func buttonsAction(sender: UIButton) {
        viewProperties?.styleButtonsAction(sender.tag)
    }
    
    private func setupSubview() {
        // Здесь мы добавляем вьюхи и настраиваем констрейнты
        guard let sectionMessageView
        else { return }
        
        view.addSubview(sectionMessageView)
        sectionMessageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.width.equalTo(24)
        }
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(sectionMessageView.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(140)
        }
        
        stackView.addArrangedSubview(infoButton)
        stackView.addArrangedSubview(warningButton)
        stackView.addArrangedSubview(successButton)
        stackView.addArrangedSubview(errorButton)
        stackView.addArrangedSubview(securityButton)
        stackView.addArrangedSubview(noneButton)
    }
}
