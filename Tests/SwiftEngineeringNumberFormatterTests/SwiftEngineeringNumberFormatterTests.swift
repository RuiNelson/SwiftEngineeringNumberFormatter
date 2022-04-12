@testable import SwiftEngineeringNumberFormatter
import XCTest

final class SwiftEngineeringNumberFormatterTests: XCTestCase {
    let pairs: [(String, Double)] = [
        ("1", 1),
        ("0", 0),
        ("1k", 1000),
        ("1m", 0.001),
        ("999M", 999e6),
        ("20µ", 20e-6),
        ("-1", -1),
        ("-100M", -100e6),
        ("-500m", -0.5),
        ("-123µ", -123e-6),
        ("3.3k", 3300),
    ]

    func testStringToDouble() throws {
        let enf = EngineeringNumberFormatter()
        enf.locale = Locale(identifier: "en_US")

        let specialPairs: [(String, Double)] = [
            ("100u", 100e-6),
            ("0.5m", 0.5e-3),
            ("-0", 0),
        ]

        var allPairs = pairs
        allPairs.append(contentsOf: specialPairs)

        for pair in allPairs {
            let input = pair.0
            let expected = pair.1
            var result = enf.double(input)

            if let r = result {
                result = round(r * 1e12) / 1e12
            }

            XCTAssert(result == expected, "Failed String to Double for value \(input), result: \(String(describing: result)), expected: \(expected)")
        }
    }

    func testDoubleToString() throws {
        let enf = EngineeringNumberFormatter()
        enf.locale = Locale(identifier: "en_US")

        for pair in pairs {
            let input = pair.1
            let expected = pair.0
            let result = enf.string(input)

            XCTAssert(result == expected, "Failed Doubble to String for value \(input), result: \(result), expected: \(expected)")
        }

        // Non-greek Mu
        enf.useGreekMu = false
        XCTAssert(enf.string(999e-6) == "999u", "Failed 999u")

        // Fraction Digits
        enf.maximumFractionDigits = 0
        XCTAssert(enf.string(3300) == "3k", "Fraction digits \(enf.string(3300))")
        XCTAssert(enf.string(2999) == "3k", "Fraction digits \(enf.string(2999))")

        enf.minimumFractionDigits = 1
        XCTAssert(enf.string(0.1) == "100.0m", "Fraction digits \(enf.string(0.1))")

        enf.maximumFractionDigits = 12
        XCTAssert(enf.string(1 / 3) == "333.333333333333m", "Fraction digits \(enf.string(1 / 3))")
    }
}
