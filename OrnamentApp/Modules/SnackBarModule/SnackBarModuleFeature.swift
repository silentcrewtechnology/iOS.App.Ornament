import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class SnackBarModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var snackBarService: SnackBarViewService
    private var variantChipsUpdaters: [ChipsViewService] = []
    private var delayChipsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        snackBarService = .init(
            viewProperties: .init(
                title: .init(string: "Title"),
                subtitle: .init(string: "Subtitle"),
                closeButton: .init(
                    action: { print("Close button tapped!") }
                ),
                bottomButton: .init(
                    title: .init(string: "Label"),
                    action: { print("Bottom button tapped") }
                )
            ),
            style: .init(
                variant: .info,
                delay: .short
            )
        )
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        variantChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Info", "Success", "Warning", "Error"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.snackBarService.update(newVariant: [.info, .success, .warning, .error][index])
                self.chipsCreationService.updateChipsSelection(for: &self.variantChipsUpdaters, selectedIndex: index)
            }
        )
        
        delayChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Short", "Long", "Infinite"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.snackBarService.update(newDelay: [.short, .long, .infinite][index])
                self.chipsCreationService.updateChipsSelection(for: &self.delayChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let variantChips = variantChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let delayChips = delayChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let showButton = ButtonViewService(
            viewProperties: .init(
                attributedText: .init(string: "Show snackBar"),
                onTap: { [weak self] in self?.showSnackBar() }
            ),
            style: .init(
                size: .large,
                color: .accent,
                variant: .primary,
                state: .default,
                icon: .without
            )
        )
        let rowModels: [DSRowModel] = [
            .init(
                center: .atom(.view(showButton.view)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(variantChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(delayChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
    
    // MARK: - Private properties
    
    private func showSnackBar() {
        snackBarService.show(on: tableViewVCBuilder.view.view)
    }
}
