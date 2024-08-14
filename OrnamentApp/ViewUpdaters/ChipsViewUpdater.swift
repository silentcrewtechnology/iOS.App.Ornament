import UIKit
import DesignSystem
import Components

final class ChipsViewUpdater {
    
    // MARK: - Properties
    
    enum State {
        case tap
        case selection(ChipsViewStyle.Selected)
    }
    
    // MARK: - Private properties
    
    private var view: ChipsView
    private var viewProperties: ChipsView.ViewProperties
    private var style: ChipsViewStyle
    private let onActive: () -> Void
    private let onInactive: () -> Void
    
    // MARK: - Life cycle
    
    init(
        view: ChipsView,
        viewProperties: ChipsView.ViewProperties,
        style: ChipsViewStyle,
        onActive: @escaping () -> Void,
        onInactive: @escaping () -> Void
    ) {
        self.view = view
        self.style = style
        self.onActive = onActive
        self.onInactive = onInactive
        self.viewProperties = viewProperties
        
        updateView()
    }
    
    // MARK: - Methods
    
    func handle(state: State) {
//        switch state {
//        case .tap(let state):
//            //handleTap(state: state)
//        case .selection(let selection):
//            //handleSelection(selection: selection)
//        }
    }
    
    // MARK: - Private methods
    
    private func updateView() {
        viewProperties.onChipsTap = { [weak self] isSelected in
            guard let self else { return }
            
            print("hello")
        }
        style.update(viewProperties: &viewProperties)
        view.update(with: viewProperties)
    }
    
//    private func handleTap(
//        state: ChipsView.State
//    ) {
//        switch (style.state, state) {
//        case (.default, .pressed):
//            style.state = .pressed
//        case (.pressed, .unpressed):
//            switch style.selection {
//            case .default:
//                style.selection = .selected
//                onActive()
//            case .selected:
//                style.selection = .default
//                onInactive()
//            }
//            style.state = .default
//        case (.pressed, .cancelled):
//            style.state = .default
//        default: return
//        }
//        
//        style.update(viewProperties: &viewProperties)
//        view.update(with: viewProperties)
//    }
    
//    private func handleSelection(
//        selection: ChipsViewStyle.Selection
//    ) {
//        switch (style.selection, selection) {
//        case (.default, .selected):
//            style.selection = .selected
//        case (.selected, .default):
//            style.selection = .default
//        default: return
//        }
//        
//        style.update(viewProperties: &viewProperties)
//        view.update(with: viewProperties)
//    }
}
