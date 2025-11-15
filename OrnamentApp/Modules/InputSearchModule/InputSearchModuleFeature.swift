import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class InputSearchModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var inputSearchService: InputSearchService
    private var stateChipsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        inputSearchService = .init(
            viewProperties: .init(
                textField: .init(
                    placeholder: .init(string: "Placeholder")
                ),
                textDidChange: { text in print(text) }
            ),
            style: .init(state: .default)
        )
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        stateChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Default", "Active"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.inputSearchService.update(newState: [.default, .active][index])
                self.chipsCreationService.updateChipsSelection(for: &self.stateChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let stateChips = stateChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                center: .atom(.view(inputSearchService.view)),
                centralBlockAlignment: .fill,
                margings: .init(leading: 8, trailing: 8),
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
