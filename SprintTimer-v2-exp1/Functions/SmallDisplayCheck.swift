//
//  SmallScreenCheck.swift
//  SprintTimer-v2-exp1
//
//  Created by Jack Smith on 2/28/21.
//

import SwiftUI


/// This doesn't work but I'd like something like it.

class SmallDisplayCheck {
    /// Using these to size fonts for split view on iPad.
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    //var isPortrait: Bool {UIDevice.current.orientation.isPortrait}
    var isCompact: Bool {horizontalSizeClass == .compact}
    var isPad: Bool {UIDevice.current.userInterfaceIdiom == .pad}
    var isSmallDisplay: Bool {isPad && isCompact}
}
