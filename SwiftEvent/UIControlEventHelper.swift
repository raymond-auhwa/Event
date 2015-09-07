//
//  UIControlEventHelper.swift
//  SwiftEvent
//
//  Created by Guanshan Liu on 9/7/15.
//  Copyright © 2015 Guanshan Liu. All rights reserved.
//

import UIKit

public class UIControlEventHelper: NSObject {

    weak var control: UIControl?
    let event: Event<UIControlEvents>

    init(control uiControl: UIControl) {
        control = uiControl
        event = Event<UIControlEvents>()

        super.init()

        uiControl.addTarget(self, action: "handleTouchUpInside", forControlEvents: .TouchUpInside)
    }

    public func handleTouchUpInside() {
        event.raise(.TouchUpInside)
    }

}

extension UIControl {

    private struct AssociatedKeys {
        static var EventHelperKey = "EventHelperKey"
    }

    public var controlEvent: Event<UIControlEvents> {
        if let eventHelper = objc_getAssociatedObject(self, &AssociatedKeys.EventHelperKey) as? UIControlEventHelper {
            return eventHelper.event
        }

        let eventHelper = UIControlEventHelper(control: self)
        objc_setAssociatedObject(self, &AssociatedKeys.EventHelperKey, eventHelper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return eventHelper.event
    }

}