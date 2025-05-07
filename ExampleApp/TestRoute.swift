//
//  TestRoute.swift
//  Routing
//
//  Created by James Sedlacek on 5/7/25.
//

import Routing
import SwiftUI

public enum TestRoute: Routable {
    case example(String)
    case lastExample

    public var body: some View {
        switch self {
        case .example(let title):
            ExampleView(title: title)
        case .lastExample:
            LastExampleView()
        }
    }
}

public enum SheetRoute: Routable {
    case sheetExample(String)

    public var body: some View {
        switch self {
        case .sheetExample(let title):
            SheetExampleView(title: title)
        }
    }
}

extension SheetRoute: @preconcurrency Identifiable {
    public var id: Self { self }
}

public enum AnotherRoute: Routable {
    case anotherExample(String)

    public var body: some View {
        switch self {
        case .anotherExample(let title):
            AnotherExampleView(title: title)
        }
    }
}
