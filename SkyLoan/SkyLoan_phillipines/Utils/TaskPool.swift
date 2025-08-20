//
//  TaskPool.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/6/9.
//

import Foundation
public actor AsyncTaskPool {
    private enum TaskState {
        case pending(priority: Int, task: (LocationModel) async throws -> Void)
        case running(Task<Void, Error>)
    }
    
    private var tasks = [UUID: TaskState]()
    private let maxConcurrentTasks: Int
    private let manager = LocationManager()
    
    public init(maxConcurrentTasks: Int = ProcessInfo.processInfo.activeProcessorCount) {
        self.maxConcurrentTasks = max(1, min(maxConcurrentTasks, 64))
    }
    
    func submit(
        priority: Int = 0,
        _ operation: @escaping (LocationModel) async throws -> Void
    ) async -> UUID {
        let id = UUID()
        tasks[id] = .pending(priority: priority, task: operation)
        await processTasks()
        return id
    }
    
    private var activeTaskCount: Int {
        tasks.values.filter {
            if case .running = $0 { return true }
            return false
        }.count
    }
    
    private func processTasks() async {
        while activeTaskCount < maxConcurrentTasks {
            guard let nextTask = getHighestPriorityPendingTask() else { break }
            
            let task = Task {
                if case .pending(_, let operation) = nextTask.state {
                    let model = try await startLocation()
                    try await operation(model)
                }
                await taskCompleted(id: nextTask.id)
            }
            tasks[nextTask.id] = .running(task)
        }
    }
    
    private func startLocation() async throws -> LocationModel{
        return try await withCheckedThrowingContinuation { continuation in
            let _ = manager.requestSingleLocation { model, error in
                continuation.resume(returning: model ?? LocationModel())
            }
        }
    }
    
    private func getHighestPriorityPendingTask() -> (id: UUID, state: TaskState)? {
        tasks
            .filter {
                if case .pending = $0.value { return true }
                return false
            }
            .max {
                guard case .pending(let p1, _) = $0.value,
                      case .pending(let p2, _) = $1.value else { return false }
                return p1 < p2
            }
            .map { ($0.key, $0.value) }
    }
    
    private func taskCompleted(id: UUID) async {
        tasks.removeValue(forKey: id)
        await processTasks()
    }
    
    public func cancelAll() {
        tasks.values.forEach { state in
            if case .running(let task) = state {
                task.cancel()
            }
        }
        tasks.removeAll()
    }
    
    public func waitAll() async {
        while !tasks.isEmpty {
            await Task.yield()
        }
    }
}
