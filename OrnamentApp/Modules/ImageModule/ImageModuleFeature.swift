import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class ImageModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var imageService: ImageViewService
    private var typeChipsUpdaters: [ChipsViewService] = []
    private var colorChipsUpdaters: [ChipsViewService] = []
    private var sizeChipsUpdaters: [ChipsViewService] = []
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        imageService = .init(
            style: .init(
                type: .letter(.init(string: "AA")),
                color: .primary,
                size: .small
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
        typeChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Letter", "Icon", "Fill image"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.imageService.update(
                    newType: [
                        .letter(.init(string: "AA")),
                        .icon(.ic24UserFilled),
                        .fillImage(UIImage(named: "imageView_fillImage") ?? .init())
                    ][index]
                )
                self.chipsCreationService.updateChipsSelection(for: &self.typeChipsUpdaters, selectedIndex: index)
            }
        )
        
        colorChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: [
                "Primary", "Main", "Main inverse", "Additional 1", "Additional 2", "Additional 3",
                "Additional 4", "Additional 5", "Additional 6", "Additional 7", "Additional 8"
            ],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.imageService.update(
                    newColor: [
                        .primary,
                        .main,
                        .mainInverse,
                        .additional1,
                        .additional2,
                        .additional3,
                        .additional4,
                        .additional5,
                        .additional6,
                        .additional7,
                        .additional8
                    ][index]
                )
                self.chipsCreationService.updateChipsSelection(for: &self.colorChipsUpdaters, selectedIndex: index)
            }
        )
        
        sizeChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Small", "Medium", "Large", "Extra large"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.tableViewBuilder.view.beginUpdates()
                self.imageService.update(
                    newSize: [
                        .small,
                        .medium,
                        .large,
                        .extraLarge
                    ][index]
                )
                self.chipsCreationService.updateChipsSelection(for: &self.sizeChipsUpdaters, selectedIndex: index)
                self.tableViewBuilder.view.endUpdates()
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let typeChips = typeChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let colorChips = colorChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        let sizeChips = sizeChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                leading: .atom(.view(imageService.view)),
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(typeChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(colorChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(sizeChips)),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            )
        ]
        
        return rowModels
    }
}
