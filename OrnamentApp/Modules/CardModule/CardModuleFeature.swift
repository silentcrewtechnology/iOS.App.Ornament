import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class CardModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var cardSevice: CardViewService
    private var setChipsUpdaters: [ChipsViewService] = []
    private var sizeChipsUpdaters: [ChipsViewService] = []
    private var stackChipsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        cardSevice = .init(
            viewProperties: .init(
                backgroundImage: .init(named: "abb"),
                maskedCardNumber: .init(string: "•• 8171")
            ),
            style: .init(
                set: .add,
                size: .small,
                stack: .false
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
        setChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Add", "Empty", "Visa", "Mir", "Mastercard"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.cardSevice.update(newSet: [.add, .empty, .visa, .mir, .mastercard][index])
                self.chipsCreationService.updateChipsSelection(for: &self.setChipsUpdaters, selectedIndex: index)
            }
        )
    
        sizeChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Small", "Medium"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.tableViewBuilder.view.beginUpdates()
                self.cardSevice.update(newSize: [.small, .medium][index])
                self.chipsCreationService.updateChipsSelection(for: &self.sizeChipsUpdaters, selectedIndex: index)
                self.tableViewBuilder.view.endUpdates()
            }
        )
        
        stackChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["False", "True"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                let stackCardViewProperties: CardView.ViewProperties = .init(
                    backgroundImage: .init(named: "abb")
                )
                self.tableViewBuilder.view.beginUpdates()
                self.cardSevice.update(
                    newStack: [
                        .false,
                        .true(stackCardViewProperties)
                    ][index]
                )
                self.chipsCreationService.updateChipsSelection(for: &self.stackChipsUpdaters, selectedIndex: index)
                self.tableViewBuilder.view.endUpdates()
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let setChips = setChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let sizeChips = sizeChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let stackChips = stackChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(cardSevice.view)),
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(setChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(sizeChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(stackChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
