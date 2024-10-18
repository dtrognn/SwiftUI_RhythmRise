//
//  MiniPlayerVM.swift
//  RhythmRise
//
//  Created by dtrognn on 16/10/24.
//

import RRCommon
import SwiftUI

final class MiniPlayerVM: BaseViewModel {
    @Published var backgroundColor: Color = ThemeManager.shared.theme.backgroundColor

    override init() {
        super.init()
    }

    func getBackgroundColor(from imageUrlString: String) {
        UtilsHelpers.getDominantColor(from: imageUrlString)
            .sink { [weak self] uiColor in
                guard let self = self else { return }

                guard let uiColor = uiColor else {
                    self.backgroundColor = ThemeManager.shared.theme.backgroundColor
                    return
                }

                self.backgroundColor = Color(uiColor: uiColor)
            }.store(in: &cancellableSet)
    }
}

extension UIColor {
    func adjusted(brightness: CGFloat, saturation: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var saturationValue: CGFloat = 0
        var brightnessValue: CGFloat = 0
        var alpha: CGFloat = 0

        self.getHue(&hue, saturation: &saturationValue, brightness: &brightnessValue, alpha: &alpha)

        brightnessValue = min(max(brightnessValue * brightness, 0), 1)
        saturationValue = min(max(saturationValue * saturation, 0), 1)

        return UIColor(hue: hue, saturation: saturationValue, brightness: brightnessValue, alpha: alpha)
    }
}
