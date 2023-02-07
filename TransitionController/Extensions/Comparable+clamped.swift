//
//  Comparable+clamper.swift
//  TransitionController
//
//  Created by Roman Bigun on 11.08.2022.
//

import UIKit

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
