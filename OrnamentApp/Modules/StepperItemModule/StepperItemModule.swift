import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class StepperItemModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var stepperItemService: StepperItemViewService
    private var stateUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        stepperItemService = .init(style: .init(state: .next))
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
    
    override func createUpdaters() {
        stateUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Next", "Current", "Success"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.stepperItemService.update(newState: [.next, .current, .success][index])
                self.chipsCreationService.updateChipsSelection(for: &self.stateUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let stateChips = stateUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                center: .atom(.view(stepperItemService.view)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(stateChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
