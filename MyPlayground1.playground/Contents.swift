
//Author: VarunRathi28
// Generic observable class for MVVM

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value)
            }
        }
    }
    
    init(value: T) {
        self.value = value
    }

    // closure to invoke on value changed
    private var valueChanged: ((T)->Void)?
    
    // Observer to assign to our closure, fireNow = true when you want to want to call something along with assigning closure: For Ex: - refreshing tableviews on initial setup
    func addObserver(fireNow:Bool = true, _ onChange:((T)->Void)?) {
        valueChanged = onChange
        if fireNow {
            onChange?(value)
        }
    }
    
    // Remove to be called by  the Observing object responsibly; Missing the call might lead to observer being added infinately and memory leak
    
    func removeObserver() {
        valueChanged = nil
    }
    
}
