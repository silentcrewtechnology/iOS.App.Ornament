import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class InputAmountModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var inputAmountService: InputAmountViewService
    private var stateChipsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        inputAmountService = .init(
            viewProperties: .init(
                textFieldProperties: .init(
                    placeholder: .init(string: "0")
                ),
                amountSymbol: .init(string: "₽")
            ),
            style: .init(state: .default)
        )
        inputAmountService.labelService.update(newText: .init(string: "Label"))
        inputAmountService.hintService.update(
            newText: .init(string: "Hint"),
            newAdditionalText: .init(string: "Hint")
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
            chipTitles: ["Default", "Active", "Error", "Disabled"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.inputAmountService.update(newState: [.default, .active, .error, .disabled][index])
                self.chipsCreationService.updateChipsSelection(for: &self.stateChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let stateChips = stateChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(inputAmountService.view)),
                margings: .init(leading: 16),
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(stateChips)),
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
