
# Rewarded

Present a sheet with a "Claim Reward" button. When the user claims, the SDK fires a callback and the host app decides what reward to deliver.

## API

```swift
public protocol RewardedViewProtocol {
    func showRewardedView()
    var onClaimReward: (() -> Void)? { get set }
}

public func makeRewardedManager(config: RewardedDialogConfig = .default) -> RewardedManager

public extension View {
    func rewardedHost(_ manager: RewardedManager, isPresented: Binding<Bool>) -> some View
}
```

## Behaviour

- `showRewardedView()` triggers presentation of the sheet via the `isPresented` binding.
- `onClaimReward` fires once when the user taps "Claim Reward". The sheet dismisses automatically afterwards.
- The host app provides the reward inside the callback (e.g. unlock a hint, award coins).

## Usage

Create a manager local to the screen that needs the reward, drive presentation through a `Bool` state, and apply the `rewardedHost` modifier:

```swift
import SwiftUI
import RewardSDK

struct GameView: View {
    @StateObject private var rewarded = makeRewardedManager()
    @State private var showAd: Bool = false
    @State private var hint: String?

    var body: some View {
        VStack {
            Button("Hint") {
                rewarded.showRewardedView()
            }
            if let hint {
                Text(hint)
            }
        }
        .rewardedHost(rewarded, isPresented: $showAd)
        .onAppear {
            rewarded.onClaimReward = {
                hint = "Your reward!"
            }
        }
    }
}
```

## Common patterns

**Gate the trigger by app state.** Hide the button until the user is in a context where a reward makes sense:

```swift
if gameInProgress {
    Button("Hint") { rewarded.showRewardedView() }
}
```

**Reset state between sessions.** Clear any reward-derived state when restarting:

```swift
func restart() {
    hint = nil
    // ...
}
```
