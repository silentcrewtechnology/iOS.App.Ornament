import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class HintModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var hintService: HintViewService
    private var variantChipsService: [ChipsViewService] = []
    private var colorChipsService: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        hintService = .init(
            viewProperties: .init(
                text: .init(string: "Text"),
                additionalText: .init(string: "Text")),
            style: .init(
                variant: .both,
                color: .default
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
        variantChipsService = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Both", "Center", "Left", "Right", "Empty"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.hintService.update(newVariant: [.both, .center, .left, .right, .empty][index])
                self.chipsCreationService.updateChipsSelection(
                    for: &self.variantChipsService,
                    selectedIndex: index
                )
            }
        )

        colorChipsService = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Default", "Active", "Error", "Disabled"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.hintService.update(newColor: [.default, .active, .error, .disabled][index])
                self.chipsCreationService.updateChipsSelection(
                    for: &self.colorChipsService,
                    selectedIndex: index
                )
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let variantChips = variantChipsService.map { updater -> (ChipsView) in updater.view }
        let colorChips = colorChipsService.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                center: .atom(.view(hintService.view)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(variantChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(colorChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
