// © Rui Carneiro

import Foundation

public extension Double {
    /// Creates a new instance from the given string written in engineering, decimal or scientific notation
    init?(engineeringNotation: String) {
        let enf = EngineeringNumberFormatter()
        guard let dbl = enf.double(engineeringNotation) else {
            return nil
        }
        self = dbl
    }
}
