/*

   SwiftEngineeringNumberFormatter

   © Rui Carneiro

 */

import Foundation

private func log1000(_ x: Double) -> Double {
    log10(x) / 3.0 // log(1000) = 3
}

public class EngineeringNumberFormatter {
    private var decimalNumberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = 12
        nf.localizesFormat = false
        return nf
    }()

    private var scientificNumberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .scientific
        nf.maximumFractionDigits = 14
        nf.localizesFormat = false
        return nf
    }()

    public var maximumFractionDigits: Int {
        get {
            decimalNumberFormatter.maximumFractionDigits
        }
        set {
            decimalNumberFormatter.maximumFractionDigits = newValue
        }
    }

    public var minimumFractionDigits: Int {
        get {
            decimalNumberFormatter.minimumFractionDigits
        }
        set {
            decimalNumberFormatter.minimumFractionDigits = newValue
        }
    }

    public var locale: Locale {
        get {
            decimalNumberFormatter.locale
        }
        set {
            decimalNumberFormatter.locale = newValue
        }
    }

    public var localizesFormat: Bool {
        get {
            decimalNumberFormatter.localizesFormat
        }
        set {
            decimalNumberFormatter.localizesFormat = newValue
        }
    }

    public var positiveSign = ""
    public var negativeSign = "-"

    /// Uses the greek letter "µ" for as a prefix for "micro", if disabled will use "u".
    public var useGreekMu: Bool = true

    public init() {}

    /// Converts a Double to engineering notation.
    public func string(_ value: Double) -> String {
        guard value != 0 else {
            return decimalNumberFormatter.string(for: value)!
        }

        let absValue = abs(value)
        let signalStr = value >= 0 ? positiveSign : negativeSign

        guard absValue >= 1000 || absValue < 1.0 else {
            return decimalNumberFormatter.string(for: value)!
        }

        let log1000 = floor(log1000(absValue))

        guard let prefix = MetricPrefixes.fromTimesThousandExponent(Int(log1000)) else {
            return scientificNumberFormatter.string(for: value)!
        }

        let multiplier = pow(1000.0, log1000)
        let multiplierStr = String(prefix.symbol(withMu: useGreekMu)!)

        let base = absValue / multiplier
        let baseStr = decimalNumberFormatter.string(for: base)!

        return signalStr + baseStr + multiplierStr
    }

    /// Converts a String with a number written in engineering notation to a Double.
    /// - Returns: A Double with the value or nil if the conversion fails.
    public func double(_ string: String) -> Double? {
        if let direct = Double(string) {
            return direct
        }

        var trimmedString = string.filter { $0.isWhitespace == false }

        let lastPart = trimmedString.removeLast()
        let firstPart = trimmedString

        guard let base = Double(firstPart), let prefix = MetricPrefixes.fromSymbol(lastPart) else {
            return nil
        }

        return base * prefix.multiplier
    }
}
