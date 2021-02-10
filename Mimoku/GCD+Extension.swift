//
//  GCD+Extension.swift
//  Mimoku_Example
//
//  Created by Mimosa on 2021/2/10.
//

import Foundation

// MARK: - AsyncTask
protocol AsyncTaskDispatchDelegate: class {
    func asyncTaskDidFinished()
}

final class AsyncTaskDispatch {
    
    static let shared = AsyncTaskDispatch()
    
    static let qos: DispatchQoS.QoSClass = .background
    
    private init() { }
    
    weak var delegate: AsyncTaskDispatchDelegate?
    
    func addAsyncTask(task: @escaping () -> Void) {
        DispatchQueue.global(qos: AsyncTaskDispatch.qos).async { [self] in
            task()
            delegate?.asyncTaskDidFinished()
        }
    }
}
