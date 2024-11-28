import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class BannerModuleFeature: BaseModuleFeature, UITextFieldDelegate {

    // MARK: Private properties

    private var bannerService: BannerViewService
    private var titleInputService: InputViewService?
    private var subtitleInputService: InputViewService?
    private var buttonInputService: InputViewService?
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
        
        titleInputService = InputViewService(
            viewProperties: .init(
                textFieldViewProperties: .init(
                    text: .init(string: ""),
                    placeholder: .init(string: "Title")
                ),
                onTextChanged: { [weak self] text in self?.onTitleTextChange(with: text) }
            ),
            style: .init(state: .default, set: .simple)
        )
        subtitleInputService = InputViewService(
            viewProperties: .init(
                textFieldViewProperties: .init(
                    text: .init(string: ""),
                    placeholder: .init(string: "Subtitle")
                ),
                onTextChanged: { [weak self] text in self?.onSubtitleTextChange(with: text) }
            ),
            style: .init(state: .default, set: .simple)
        )
        buttonInputService = InputViewService(
            viewProperties: .init(
                textFieldViewProperties: .init(
                    text: .init(string: ""),
                    placeholder: .init(string: "Button text")
                ),
                onTextChanged: { [weak self] text in self?.onButtonTextChange(with: text) }
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
                center: .atom(.view(titleInputService?.view ?? .init())),
                centralBlockAlignment: .fill,
                margings: .init(bottom: 8),
                cellSelectionStyle: .none
            ),
            .init(
                center: .atom(.view(subtitleInputService?.view ?? .init())),
                centralBlockAlignment: .fill,
                margings: .init(bottom: 8),
                cellSelectionStyle: .none
            ),
            .init(
                center: .atom(.view(buttonInputService?.view ?? .init())),
                centralBlockAlignment: .fill,
                margings: .init(bottom: 8),
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(variantChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
    
    // MARK: - Private methods

    private func onTitleTextChange(with text: String?) {
        tableViewBuilder.view.beginUpdates()
        
        guard let text, !text.isEmpty else {
            bannerService.update(newTitle: .init())
            tableViewBuilder.view.endUpdates()
            return
        }
        
        bannerService.update(newTitle: .init(string: text))
        tableViewBuilder.view.endUpdates()
    }
    
    private func onSubtitleTextChange(with text: String?) {
        tableViewBuilder.view.beginUpdates()
        
        guard let text, !text.isEmpty else {
            bannerService.update(newSubtitle: .init())
            tableViewBuilder.view.endUpdates()
            return
        }
        
        bannerService.update(newSubtitle: .init(string: text))
        tableViewBuilder.view.endUpdates()
    }
    
    private func onButtonTextChange(with text: String?) {
        tableViewBuilder.view.beginUpdates()
        
        guard let text, !text.isEmpty else {
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
