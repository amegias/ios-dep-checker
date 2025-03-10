import Foundation

public enum CustomResult<T: Encodable & Sendable, E: Error>: Sendable {
    case success(T)
    case failure(E)
}

extension CustomResult: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .success(let value):
            try container.encode(value, forKey: .success)
        case .failure(let error):
            try container.encode(String(describing: error), forKey: .failure)
        }
    }

    private enum CodingKeys: String, CodingKey {
        case success
        case failure
    }
}

extension CustomResult: CustomStringConvertible {
    public var description: String {
        switch self {
        case .success(let t):
            "\(t)"
        case .failure(let e):
            "Error: \(e)"
        }
    }
}
