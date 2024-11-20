import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class ButtonPayModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var buttonPayService: ButtonPayService
    private var typeUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        buttonPayService = .init(
            viewProperties: .init(text: .init(string: "Добавить в")),
            style: .init(type: .samsung)
        )
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        typeUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Samsung", "SBP", "Google", "Apple", "Yandex"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.buttonPayService.update(newType: [.samsung, .sbp, .google, .apple, .yandex][index])
                self.chipsCreationService.updateChipsSelection(for: &self.typeUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let typeChips = typeUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(buttonPayService.view)),
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(typeChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
