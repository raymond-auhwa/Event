//
//  Event.swift
//  SwiftEvent
//
//  Created by Guanshan Liu on 9/7/15.
//  Copyright © 2015 Guanshan Liu. All rights reserved.
//

import Foundation

public class Event<T: Hashable> {

    public typealias EventHandler = () -> ()

    private var eventHandlers = [T: Invocable]()

    public func raise(data: T) {
        eventHandlers[data]?.invoke()
    }

    func setTarget<U: AnyObject>(target: U, handler: (U) -> EventHandler, controlEvent: T) {
        eventHandlers[controlEvent] = EventHandlerWrapper(
                target: target, handler: handler)
    }

    func removeTargetForControlEvent(controlEvent: T) {
        eventHandlers[controlEvent] = nil
    }
}

private protocol Invocable: class {
    func invoke()
}

private class EventHandlerWrapper<T: AnyObject> : Invocable {
    weak var target: T?
    let handler: T -> () -> ()

    init(target: T?, handler: T -> () -> ()) {
        self.target = target
        self.handler = handler
    }

    func invoke() {
        if let t = target {
            handler(t)()
        }
    }
}