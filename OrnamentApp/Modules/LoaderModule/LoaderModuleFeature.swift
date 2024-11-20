import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class LoaderModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var loaderService: LoaderViewService
    private var colorChipsUpdaters: [ChipsViewService] = []
    private var sizeChipsUpdaters: [ChipsViewService] = []
    private var isHiddenChipsUpdaters: [ChipsViewService] = []
    private var isHidden = false
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        loaderService = .init(style: .init(color: .accent, size: .s), isHidden: false)
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        colorChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Accent", "Main", "Disabled", "Primary", "Custom"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self else { return }
                
                self.loaderService.update(
                    newColor: [.accent, .main, .disabled, .primary, .custom(.red)][index],
                    isHidden: self.isHidden
                )
                self.chipsCreationService.updateChipsSelection(for: &self.colorChipsUpdaters, selectedIndex: index)
            }
        )
        
        sizeChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["S", "M", "L", "XL"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self else { return }
                
                self.tableViewBuilder.view.beginUpdates()
                self.loaderService.update(
                    newSize: [.s, .m, .l, .xl][index],
                    isHidden: self.isHidden
                )
                self.chipsCreationService.updateChipsSelection(for: &self.sizeChipsUpdaters, selectedIndex: index)
                self.tableViewBuilder.view.endUpdates()
            }
        )
        
        isHiddenChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Not hidden", "Hidden"],
            selectedIndex: .zero,
            onChipTap: { [weak self] index in
                guard let self else { return }
                
                self.isHidden = [false, true][index]
                self.loaderService.update(isHidden: self.isHidden)
                self.chipsCreationService.updateChipsSelection(for: &self.isHiddenChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let colorChips = colorChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let sizeChips = sizeChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let isHiddenChips = isHiddenChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(loaderService.view)),
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(colorChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(sizeChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                leading: .molecule(.horizontalChipsViews(isHiddenChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
        ]
        
        return rowModels
    }
}
