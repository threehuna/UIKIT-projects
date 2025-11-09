//
//  CalendarEventManager.swift
//  ivvlivanovPW2
//
//  Created by Иван Иванов on 07.11.2025.
//
import UIKit
import EventKit
import Foundation




final class CalendarManager: CalendarManaging { //HW4
    static let shared = CalendarManager()
    private let eventStore = EKEventStore()
    private init() {}

    func create(eventModel: CalendarEventModel, completion: @escaping (Bool) -> Void) {
        let handler: (Bool, Error?) -> Void = { [weak self] granted, error in
            guard let self = self, granted, error == nil else {
                completion(false)
                return
            }

            let event = EKEvent(eventStore: self.eventStore)
            event.title = eventModel.title
            event.startDate = eventModel.startDate
            event.endDate = eventModel.endDate
            event.notes = eventModel.note
            event.calendar = self.eventStore.defaultCalendarForNewEvents

            do {
                try self.eventStore.save(event, span: .thisEvent)
                completion(true)
            } catch {
                print("CalendarManager: failed to save event: \(error)")
                completion(false)
            }
        }

        if #available(iOS 17.0, *) {
            // requestFullAccessToEvents(completion:) — iOS 17+
            eventStore.requestFullAccessToEvents { granted, error in
                handler(granted, error)
            }
        } else {
            eventStore.requestAccess(to: .event) { granted, error in
                handler(granted, error)
            }
        }
    }

    func createSync(eventModel: CalendarEventModel) -> Bool {
        let sem = DispatchSemaphore(value: 0)
        var result = false
        create(eventModel: eventModel) { success in
            result = success
            sem.signal()
        }
        _ = sem.wait(timeout: .now() + 10) 
        return result
    }
}
