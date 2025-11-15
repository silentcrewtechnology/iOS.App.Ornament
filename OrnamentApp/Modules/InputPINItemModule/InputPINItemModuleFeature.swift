import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class InputPINItemModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var pinItemService: InputPinItemViewService
    private var variantChipsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        pinItemService = .init(style: .init(variant: .default))
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        variantChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Default", "Filled", "Success", "Error"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.pinItemService.update(variant: [.default, .filled, .success, .error][index])
                self.chipsCreationService.updateChipsSelection(for: &self.variantChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let variantChips = variantChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(pinItemService.view)),
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
}
