

---

## 2. `docs/Integration.md`

```markdown
# Integration

`RewardSDK` is built as a framework target inside the Mastermind Xcode project.

## Adding to a target

In the host app target:

1. Open the project settings → **General** tab.
2. Under **Frameworks, Libraries, and Embedded Content**, add `RewardSDK.framework`.
3. Set its embed option to **Embed & Sign**.

## Importing

```swift
import RewardSDK
