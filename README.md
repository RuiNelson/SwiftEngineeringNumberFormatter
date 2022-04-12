# SwiftEngineeringNumberFormatter
Number formatter using the engineering notation. [All SI metric prefixes](https://en.wikipedia.org/wiki/Metric_prefix) are supported.

## Basic Use

    import SwiftEngineeringNumberFormatter
    
    // Instantiate the class:
    let enf = EngineeringNumberFormatter()

    // Convert String to Double?
    enf.double("10k")                      // returns 10E3
    enf.double(":P")                       // returns nil

    // Convert Double to String
    enf.double(123E-6)                     // returns "123µ"

    // Use "u" instead of "µ"
    enf.useGreekMu = false
    enf.double(123E-6)                     // returns "123u"

    // Set the number of decimal places
    enf.maximumFractionDigits = 1
    enf.double(1.0 / 3.0)                  // returns "333.3m"

    enf.maximumFractionDigits = 0
    enf.double(2999)                       // returns "3k"


## Add to your Swift Package Manager Project

See an example [here](https://github.com/RuiCarneiro/rigol2spice/blob/main/Package.swift).

Add package dependencies:

    .package(url: "https://github.com/RuiCarneiro/SwiftEngineeringNumberFormatter", from: "1.0.0")

And to your target, the dependency:

    .product(name: "SwiftEngineeringNumberFormatter", package: "SwiftEngineeringNumberFormatter")

## Copyright and License

(C) Rui Carneiro

Licensed under Apache License 2.0
