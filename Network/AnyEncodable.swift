//
//  AnyEncodable.swift
//  Pods-VichmsAPI_Example
//
//  Created by user195857 on 6/21/21.
//

import Foundation

struct AnyEncodable: Encodable {

    private let _encode: (Encoder) throws -> Void
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }

    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
