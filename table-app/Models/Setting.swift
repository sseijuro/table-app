//
//  Setting.swift
//  table-app
//
//  Created by Alexandr Kozorez on 07.02.2022.
//

import Foundation

struct Setting {
    let title: String
    var avatar: URL? = nil
    var subtitle: String? = nil
    var caption: String? = nil
    var isActive: Bool = false
}

extension Setting {
    static var defaultSettingsList: [Setting] { [
        Setting(title: "Title"),
        Setting(title: "Title", subtitle: "Subtitle"),
        Setting(title: "Title", subtitle: loremOneParagraph),
        Setting(title: "Title", subtitle: loremOneParagraph, caption: "Caption"),
        Setting(title: loremOneParagraph),
        Setting(title: loremOneParagraph, subtitle: "Subtitle"),
        Setting(title: loremOneParagraph, subtitle: loremOneParagraph),
        Setting(title: loremOneParagraph, subtitle: loremOneParagraph, caption: "Caption")
    ] }

    static var loremOneParagraph: String {
        """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et \
         dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip \
         ex ea commodo consequat.
        """
    }
}
