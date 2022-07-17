# Color Picker

Create a color picker with 3 Slider that shows the hex value of the color, percentages of red, green and blue and the actual color in a SwiftUI Rectangle.

<video controls>
    <source src="https://storage.googleapis.com/noah-education-videos/swiftui/2-color-picker.mp4"
            type="video/mp4">
</video>

## [Code](https://github.com/phptuts/ios-mini-projects/blob/main/ColorPicker/ColorPicker/ContentView.swift)



## Code To Copy

```swift
extension Color {
    func hexString() -> String {
        let components = self.cgColor?.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }
}

extension Double {
    func toPercent() -> String {
        String(format:"%6.2f%%",self * 100)
    }
}
```


## Resources

- [Discord](https://discord.gg/Jwv7xaPRMS)
- [SwiftUI Slider](https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-a-slider-and-read-values-from-it)
- [SwiftUI Rectangle](https://www.hackingwithswift.com/quick-start/swiftui/how-to-display-solid-shapes)
- [State](https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-state-property-wrapper)
