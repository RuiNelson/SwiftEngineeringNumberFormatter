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
            scientificNumberFormatter.maximumFractionDigits = newValue
        }
    }

    public var minimumFractionDigits: Int {
        get {
            decimalNumberFormatter.minimumFractionDigits
        }
        set {
            decimalNumberFormatter.minimumFractionDigits = newValue
            scientificNumberFormatter.minimumFractionDigits = newValue
        }
    }

    public var locale: Locale {
        get {
            decimalNumberFormatter.locale
        }
        set {
            decimalNumberFormatter.locale = newValue
            scientificNumberFormatter.locale = newValue
        }
    }

    public var localizesFormat: Bool {
        get {
            decimalNumberFormatter.localizesFormat
        }
        set {
            decimalNumberFormatter.localizesFormat = newValue
            scientificNumberFormatter.localizesFormat = newValue
        }
    }

    public var positiveSign = ""
    public var negativeSign = "-"

    /// Uses the greek letter "µ" for as a prefix for "micro", if false will use "u".
    public var useGreekMu: Bool = true

    public init() {}

    /// Returns a String with the Double value written in Engineering Notation
    public func string(_ value: Double) -> String {
        guard value != 0 else {
            return decimalNumberFormatter.string(for: value)!
        }

        let absValue = abs(value)
        let signalStr = value >= 0 ? positiveSign : negativeSign

        guard absValue >= 1000 || absValue < 1.0 else {
            return decimalNumberFormatter.string(for: value)!
        }

        let logarithm = floor(log1000(absValue))

        guard let prefix = MetricPrefixes.fromTimesThousandExponent(Int(logarithm)) else {
            return scientificNumberFormatter.string(for: value)!
        }

        let multiplier = pow(1000.0, logarithm)
        let multiplierChr = prefix.symbol(withMu: useGreekMu)!

        let base = absValue / multiplier
        let baseStr = decimalNumberFormatter.string(for: base)!

        return signalStr + baseStr + String(multiplierChr)
    }

    /// Parses a String in Engineering, Scientific or Decimal notation to a Double
    /// - Returns: A Double with the value or nil if the conversion fails
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
