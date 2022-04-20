// © Rui Carneiro

import Foundation

func log1000(_ x: Double) -> Double {
    log10(x) / 3.0 // log(1000) = 3
}

func pow(_ x: Double, _ y: Int) -> Double {
    let yDbl = Double(y)

    return pow(x, yDbl)
}
