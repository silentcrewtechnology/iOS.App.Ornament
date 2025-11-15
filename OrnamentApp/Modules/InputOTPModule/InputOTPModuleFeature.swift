import UIKit
import Architecture
import ArchitectureTableView
import Extensions
import DesignSystem
import Components

final class InputOTPModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var inputOTPService: InputOTPViewService
    private var stateChipsUpdaters: [ChipsViewService] = []
    private var currentIndex: Int = .zero
    
    // MARK: - Init
    
    override init(
        tableDataSource: TableDataSource = .init(),
        tableDelegate: TableDelegate = .init(),
        navigationBarViewPropertiesService: NavigationBarViewPropertiesService = .init()
    ) {
        inputOTPService = .init(style: .init(state: .default))
        inputOTPService.hintService.update(newText: .init(string: "Hint"))
        
        super.init(
            tableDataSource: tableDataSource,
            tableDelegate: tableDelegate,
            navigationBarViewPropertiesService: navigationBarViewPropertiesService
        )
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        inputOTPService = .init(
            viewProperties: .init(
                textFieldViewProperties: .init(
                    textContentType: .oneTimeCode,
                    keyboardType: .numberPad,
                    isHidden: true
                ),
                onTextChanged: { [weak self] text in
                    self?.currentIndex = text?.count ?? .zero
                    print(text)
                }
            ),
            style: .init(state: .default),
            itemServices: [
                .init(style: .init(state: .default)),
                .init(style: .init(state: .default)),
                .init(style: .init(state: .default)),
                .init(style: .init(state: .default)),
                .init(style: .init(state: .default)),
                .init(style: .init(state: .default))
            ]
        )
        
        stateChipsUpdaters = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Default", "Active", "Error", "Disabled"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                self.inputOTPService.update(
                    newState: [.default, .active, .error, .disabled][index],
                    range: [0..<6, currentIndex..<currentIndex + 1, 0..<6, 0..<6][index]
                )
                self.chipsCreationService.updateChipsSelection(for: &self.stateChipsUpdaters, selectedIndex: index)
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let stateChips = stateChipsUpdaters.map { updater -> (ChipsView) in updater.view }
        
        let rowModels: [DSRowModel] = [
            .init(
                center: .atom(.view(inputOTPService.view)),
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
