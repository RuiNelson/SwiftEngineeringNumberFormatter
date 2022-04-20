// © Rui Carneiro

import Foundation

extension EngineeringNumberFormatter {
    enum MetricPrefixes: Int, CaseIterable {
        case yotta = 8, zetta = 7, exa = 6, peta = 5, tera = 4, giga = 3, mega = 2, kilo = 1
        case none = 0
        case milli = -1, micro = -2, nano = -3, pico = -4, femto = -5, atto = -6, zepto = -7, yocto = -8

        var multiplier: Double {
            let selfValue = rawValue
            let exponent = selfValue * 3
            return pow(10.0, exponent)
        }

        private var symbolWithMu: Character? {
            switch self {
            case .yotta: return "Y"
            case .zetta: return "Z"
            case .exa: return "E"
            case .peta: return "P"
            case .tera: return "T"
            case .giga: return "G"
            case .mega: return "M"
            case .kilo: return "k"
            case .none: return nil
            case .milli: return "m"
            case .micro: return "µ"
            case .nano: return "n"
            case .pico: return "p"
            case .femto: return "f"
            case .atto: return "a"
            case .zepto: return "z"
            case .yocto: return "y"
            }
        }

        func symbol(withMu: Bool = true) -> Character? {
            if self == .micro, !withMu {
                return "u"
            } else {
                return symbolWithMu
            }
        }

        static func fromSymbol(_ symbol: Character) -> MetricPrefixes? {
            if symbol == "u" {
                return .micro
            }

            return MetricPrefixes.allCases.first { $0.symbolWithMu == symbol }
        }

        static func fromTimesThousandExponent(_ exp: Int) -> MetricPrefixes? {
            MetricPrefixes(rawValue: exp)
        }
    }
}
