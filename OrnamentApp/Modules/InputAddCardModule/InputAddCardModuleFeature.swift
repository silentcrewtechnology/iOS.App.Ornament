import UIKit
import Extensions
import DesignSystem
import Components
import ImagesService

final class InputAddCardModuleFeature: BaseModuleFeature {
    
    // MARK: - Private properties
    
    private var viewService: InputAddCardViewService = .init(
        cardNumberHintedFieldService: .init(
            viewProperties: .init(
                textFieldViewProperties: .init(
                    placeholder: "Card number".attributed,
                    textContentType: .creditCardNumber
                )
            )
        ),
        buttonIconService: .init(
            viewProperties: .init(image: .ic16ArrowRight),
            style: .init(variant: .primary, size: .small, state: .default, color: .accent)
        ),
        dateHintedFieldService: .init(
            viewProperties: .init(
                textFieldViewProperties: .init(
                    placeholder: "MM/YY".attributed,
                    textContentType: { if #available(iOS 17.0, *) { .creditCardExpiration } else { nil } }()
                ),
                insets: .init(top: 12, left: 72, bottom: 12, right: 16)
            )
        )
    )
    private var cardViewServices: [ChipsViewService] = []
    private var numberHintServices: [ChipsViewService] = []
    private var dateVisibilityServices: [ChipsViewService] = []
    private var buttonIconVisibilityServices: [ChipsViewService] = []
    private var dateHintServices: [ChipsViewService] = []
    private var stateServices: [ChipsViewService] = []
    
    // MARK: - Init
    
    init() {
        super.init()
        viewService.buttonIconService?.view.isHidden = true
    }
    
    // MARK: Methods
 
    override func createUpdaters() {
        cardViewServices = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Empty card", "Filled card"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                let newSet: CardViewStyle.Set = index == 0 ? .empty : .mir
                tableViewBuilder.view.beginUpdates()
                viewService.cardViewService.update(newSet: newSet, newBackgroundImage: .cardBackground)
                chipsCreationService.updateChipsSelection(for: &cardViewServices, selectedIndex: index)
                tableViewBuilder.view.endUpdates()
            }
        )
        numberHintServices = chipsCreationService.createChipsUpdaters(
            chipTitles: ["No card hint", "Hint", "Card error"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                var (state, hint): (InputAddCardHintedFieldStyle.State?, NSMutableAttributedString?)
                switch index {
                case 0: state = .default; hint = "".attributed
                case 1: state = .default; hint = "Bank name".attributed
                case 2: state = .error; hint = "Error".attributed
                default: break
                }
                tableViewBuilder.view.beginUpdates()
                viewService.cardNumberHintedFieldService.update(newState: state, newHint: hint)
                chipsCreationService.updateChipsSelection(for: &numberHintServices, selectedIndex: index)
                tableViewBuilder.view.endUpdates()
            }
        )
        dateVisibilityServices = chipsCreationService.createChipsUpdaters(
            chipTitles: ["No date", "Show date"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                tableViewBuilder.view.beginUpdates()
                viewService.dateHintedFieldService.view.isHidden = index == 0
                chipsCreationService.updateChipsSelection(for: &dateVisibilityServices, selectedIndex: index)
                tableViewBuilder.view.endUpdates()
            }
        )
        dateHintServices = chipsCreationService.createChipsUpdaters(
            chipTitles: ["No date hint", "Date error"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                var (state, hint): (InputAddCardHintedFieldStyle.State?, NSMutableAttributedString?)
                switch index {
                case 0: state = .default; hint = "".attributed
                case 1: state = .error; hint = "Error".attributed
                default: break
                }
                tableViewBuilder.view.beginUpdates()
                viewService.dateHintedFieldService.update(newState: state, newHint: hint)
                chipsCreationService.updateChipsSelection(for: &dateHintServices, selectedIndex: index)
                tableViewBuilder.view.endUpdates()
            }
        )
        buttonIconVisibilityServices = chipsCreationService.createChipsUpdaters(
            chipTitles: ["No button", "Button"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                tableViewBuilder.view.beginUpdates()
                viewService.buttonIconService?.view.isHidden = index == 0
                chipsCreationService.updateChipsSelection(for: &buttonIconVisibilityServices, selectedIndex: index)
                tableViewBuilder.view.endUpdates()
            }
        )
        stateServices = chipsCreationService.createChipsUpdaters(
            chipTitles: ["Default state", "Disabled state"],
            onChipTap: { [weak self] index in
                guard let self = self else { return }
                let newState: InputAddCardViewStyle.State = index == 0 ? .default : .disabled
                tableViewBuilder.view.beginUpdates()
                viewService.update(newState: newState)
                chipsCreationService.updateChipsSelection(for: &stateServices, selectedIndex: index)
                tableViewBuilder.view.endUpdates()
            }
        )
    }
    
    override func createRowModels() -> [DSRowModel] {
        let rowModels: [DSRowModel] = [
            .init(
                center: .atom(.view(viewService.view)),
                centralBlockAlignment: .fill,
                margings: .init(),
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(cardViewServices.map(\.view))),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(numberHintServices.map(\.view))),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(dateVisibilityServices.map(\.view))),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(dateHintServices.map(\.view))),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(buttonIconVisibilityServices.map(\.view))),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
            .init(
                center: .molecule(.horizontalChipsViews(stateServices.map(\.view))),
                centralBlockAlignment: .fill,
                cellSelectionStyle: .none
            ),
        ]
        
        return rowModels
    }
}
