import SwiftUI

public struct Toast: Equatable {
    public let style: ToastStyle
    public let message: String
    public let duration: Double
    public let width: Double

    public init(style: ToastStyle, message: String, duration: Double = 3, width: Double = .infinity) {
        self.style = style
        self.message = message
        self.duration = duration
        self.width = width
    }
}

public enum ToastStyle {
    case error
    case warning
    case success
    case info
}

extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .error: return Color.red
        case .warning: return Color.orange
        case .info: return Color.blue
        case .success: return Color.green
        }
    }

    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
}

public struct ToastView: View {
    private let style: ToastStyle
    private let message: String
    private let width: CGFloat
    private let onCancelTapped: (() -> Void)

    public init(
        style: ToastStyle,
        message: String,
        width: CGFloat = CGFloat.infinity,
        onCancelTapped: @escaping () -> Void
    ) {
        self.style = style
        self.message = message
        self.width = width
        self.onCancelTapped = onCancelTapped
    }

    public var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: style.iconFileName)
                .foregroundColor(.black)

            Text(message)
                .font(Font.caption)
                .foregroundColor(.black)

            Spacer(minLength: 10)

            Button {
                onCancelTapped()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: width)
        .background(style.themeColor)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .opacity(0)
        )
        .padding(.horizontal, 16)
    }
}
