//
//  WorkItem.swift
//  loodos
//
//  Created by Berkay Delen on 6.08.2020.
//

import Foundation

class WorkItem {

    private var pendingRequestWorkItem: DispatchWorkItem?

    func perform(after: TimeInterval, _ block: @escaping () -> Void) {
        // Cancel the currently pending item
        pendingRequestWorkItem?.cancel()

        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem(block: block)

        pendingRequestWorkItem = requestWorkItem

        DispatchQueue.main.asyncAfter(deadline: .now() + after, execute: requestWorkItem)
    }
}
