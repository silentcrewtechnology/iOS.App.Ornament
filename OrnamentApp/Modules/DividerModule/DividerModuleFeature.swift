import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class DividerModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var dividerService: DividerViewService
    private var variantChipsUpdaters: [ChipsViewService] = []
    private var styleChipsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        dividerService = .init(style: .init(variant: .horizontal, style: .secondary))
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        variantChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Horizontal", "Vertical"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.dividerService.update(variant: [.horizontal, .vertical][index])
                self.chipsCreationService.updateChipsSelection(for: &self.variantChipsUpdaters, selectedIndex: index)
            }
        )
        
        styleChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Secondary", "Main", "Accent"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.dividerService.update(style: [.secondary, .main, .accent][index])
                self.chipsCreationService.updateChipsSelection(for: &self.styleChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let variantChips = variantChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let styleChips = styleChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(dividerService.view)),
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(variantChips)),
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(styleChips)),
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
