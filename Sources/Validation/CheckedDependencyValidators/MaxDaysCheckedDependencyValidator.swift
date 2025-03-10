import Foundation
import Models

public struct MaxDaysCheckedDependencyValidator {
    enum ValidationError: Error {
        case exceedsMaxDays(_ dependencyName: String)
    }

    public init() {}
}

extension MaxDaysCheckedDependencyValidator: CheckedDependencyValidator {
    func validate(_ checkedDependencies: [CheckedDependency]) throws {
        for dependency in checkedDependencies {
            try dependency.validate()
        }
    }
}

private extension CheckedDependency {
    func validate() throws(MaxDaysCheckedDependencyValidator.ValidationError) {
        if let outdated, outdated.isOutdated {
            throw MaxDaysCheckedDependencyValidator.ValidationError.exceedsMaxDays(name)
        }
    }
}
