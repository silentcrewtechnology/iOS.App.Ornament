import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class BannerModuleFeature: BaseModuleFeature, UITextFieldDelegate {

    // MARK: Private properties

    private var bannerService: BannerViewService
    private var variantUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        bannerService = .init(style: .init(variant: .neutral))
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
    
    override func createUpdaters() {
        variantUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Neutral", "Warning", "Error", "Success"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.bannerService.update(newVariant: [.neutral, .warning, .error, .success][index])
                self.chipsCreationService.updateChipsSelection(
                    for: &self.variantUpdaters,
                    selectedIndex: index
                )
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let variantChips = variantUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let titleInputService = InputViewService(
            viewProperties: .init(
                textFieldViewProperties: .init(
                    text: .init(string: ""),
                    delegateAssigningClosure: { textField in
                        textField.delegate = self
                        textField.addTarget(
                            self,
                            action: #selector(self.onTitleTextChange(textField:)),
                            for: .editingChanged
                        )
                    }
                )
            ),
            style: .init(state: .default, set: .simple)
        )
        let subtitleInputService = InputViewService(
            viewProperties: .init(
                textFieldViewProperties: .init(
                    text: .init(string: ""),
                    delegateAssigningClosure: { textField in
                        textField.delegate = self
                        textField.addTarget(
                            self,
                            action: #selector(self.onSubtitleTextChange(textField:)),
                            for: .editingChanged
                        )
                    }
                )
            ),
            style: .init(state: .default, set: .simple)
        )
        let buttonInputService = InputViewService(
            viewProperties: .init(
                textFieldViewProperties: .init(
                    text: .init(string: ""),
                    delegateAssigningClosure: { textField in
                        textField.delegate = self
                        textField.addTarget(
                            self,
                            action: #selector(self.onButtonTextChange(textField:)),
                            for: .editingChanged
                        )
                    }
                )
            ),
            style: .init(state: .default, set: .simple)
        )
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(bannerService.view)),
                margings: BannerConstants.bannerMargins,
                cellSelectionStyle: .none
            ),
            .init(
                leading: .atom(.inputView(titleInputService.viewProperties, titleInputService.style)),
                margings: BannerConstants.zeroMargins,
                cellSelectionStyle: .none,
                height: 80
            ),
            .init(
                leading: .atom(.inputView(subtitleInputService.viewProperties, subtitleInputService.style)),
                margings: BannerConstants.zeroMargins,
                cellSelectionStyle: .none,
                height: 80
            ),
            .init(
                leading: .atom(.inputView(buttonInputService.viewProperties, buttonInputService.style)),
                margings: BannerConstants.zeroMargins,
                cellSelectionStyle: .none,
                height: 80
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(variantChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
    
    // MARK: - Private methods

    @objc private func onTitleTextChange(textField: UITextField) {
        tableViewBuilder.view.beginUpdates()
        
        guard let text = textField.text, !text.isEmpty else {
            bannerService.update(newTitle: .init())
            tableViewBuilder.view.endUpdates()
            return
        }
        
        bannerService.update(newTitle: .init(string: text))
        tableViewBuilder.view.endUpdates()
    }
    
    @objc private func onSubtitleTextChange(textField: UITextField) {
        tableViewBuilder.view.beginUpdates()
        
        guard let text = textField.text, !text.isEmpty else {
            bannerService.update(newSubtitle: .init())
            tableViewBuilder.view.endUpdates()
            return
        }
        
        bannerService.update(newSubtitle: .init(string: text))
        tableViewBuilder.view.endUpdates()
    }
    
    @objc private func onButtonTextChange(textField: UITextField) {
        tableViewBuilder.view.beginUpdates()
        
        guard let text = textField.text, !text.isEmpty else {
            bannerService.update(newBottomButton: .init())
            tableViewBuilder.view.endUpdates()
            return
        }
        
        bannerService.update(newBottomButton: .init(text: .init(string: text)))
        tableViewBuilder.view.endUpdates()
    }
}

// MARK: - Constants

private enum BannerConstants {
    static let zeroMargins: RowBaseContainer.ViewProperties.Margins = .init(
        leading: .zero,
        trailing: .zero,
        top: .zero,
        bottom: .zero,
        spacing: .zero
    )
    static let bannerMargins: RowBaseContainer.ViewProperties.Margins = .init(
        leading: .zero,
        trailing: .zero,
        top: .zero,
        bottom: 16,
        spacing: .zero
    )
}
