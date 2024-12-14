# PortfolioApp
회원가입 / 자산배분 / 주식 목록 화면으로 이루어져 있는 자산관리 포트폴리오 앱

## 개발 환경
- Xcode 16.1
- macOS 15.1.1
- 최소지원버전 iOS 16

## 사용 기술
- SwiftUI, MVVM

## 주요 화면 스크린샷
| 회원가입                                      | 유효성 검사 실패                             | 유효성 검사 성공                             | 자산 배분                                   | 주식 목록                                   |
|----------------------------------------------|----------------------------------------------|----------------------------------------------|---------------------------------------------|---------------------------------------------|
| <img src="https://github.com/user-attachments/assets/e0fc3212-0254-437e-8eb9-3f3c66442091" width=200> | <img src="https://github.com/user-attachments/assets/6a811bd7-7c0f-439f-90ad-9d447b86b2ac" width=200> | <img src="https://github.com/user-attachments/assets/14db9a6c-ddff-44ed-9e7a-19bb45bec2f2" width=200> | <img src="https://github.com/user-attachments/assets/b81f4d27-5b95-41e8-b294-ad86ac01ab44" width=200> | <img src="https://github.com/user-attachments/assets/8afb8eb4-4799-4d7f-a0a1-e1f5f2226675" width=200> |

## 주요 기능 동작 영상
| 회원가입 플로우 (2배속) | 자산 배분 <-> 주식 목록 화면이동 | 회원가입 완료 시 곧바로 메인으로 이동 |
| -- | -- | -- |
| <img src="https://github.com/user-attachments/assets/f9569469-b160-4b59-80f0-d5ff4bb298a7" width=250>| <img src="https://github.com/user-attachments/assets/06ba8613-0983-4454-9016-b47fb0dd3b2f" width=250> | <img src="https://github.com/user-attachments/assets/eb2c1b8a-d854-446a-8f2e-09e02399e8d2" width=250> |

## 주요 구현 사항
### 회원가입 화면 입력 예외처리
- 회원가입 화면에서 아이디, 비밀번호, 전화번호, 이메일 양식에 맞지 않을 경우에 대한 예외처리를 진행하였습니다.
- 입력제한 길이를 넘어가면 입력이 불가하도록 구현하였습니다.
- 값이 유효하지 않은 경우 그 이유를 각각 출력하도록 구현하였습니다.

### 사용성 좋은 회원가입 플로우 구현
- 키보드로 텍스트 입력 후 키보드 우측 하단의 next 버튼을 입력해 다음 필드로 이동할 수 있도록 구현하였습니다.
- 만약 입력 중인 필드 값이 유효하지 않다면 입력 중인 필드에 유효하지 않음 표시를 나타내고 입력 중인 필드에 포커스를 유지하도록 구현하였습니다.
- 따라서 사용자는 텍스트필드 터치 없이 next 버튼만 탭해서 모든 필드를 이동하며 값을 작성할 수 있습니다.

### 사용자 상호작용성을 고려한 입력 애니메이션 처리
- 회원가입 화면에서 값이 유효하지 않은 필드가 있을 경우 해당 텍스트필드에 shake 애니메이션을 주어 유저가 어떤 필드에 문제가 있는지 곧바로 알 수 있도록 구현하였습니다.

### 단계별 색상 구현
- 주식, 채권, 기타 자산 유형의 세부 카테고리 색상을 나타내기 위해 각 유형마다 베이스 색상을 지정, 하위 카테고리는 베이스 색상으로부터 명도를 10%씩 낮추는 방식으로 연관성 확인이 쉬운 색상 그래프를 구현하였습니다.

## 파이 차트 구현
- 주어진 데이터가 전체 값에서 차지하는 비율을 360에서 차지하는 비율로 변환해 데이터 슬라이스가 차지할 각도를 구하고, 해당 각도를 사용해 슬라이스를 그려내는 방식으로 파이 차트를 구현하였습니다.

## 쫀득한 스크롤뷰 구현
- 스크롤뷰 내뷰 뷰에 투명 색상을 백그라운드로 깔고, GeometryReader / PreferenceKey를 사용해 해당 뷰의 위치값을 알아와 스크롤뷰의 offset을 감지하였습니다.
- 해당 offset에 따라 투톤으로 설정된 배경색의 프레임이 움직이게 하여 스크롤에 반응하도록 만들어 쫀득한 스크롤뷰를 구현하였습니다.

## 주요 고민 사항
1. **[키보드 바운스 문제 해결하기](https://github.com/ericKwon95/PortfolioApp/pull/1)**
2. **[자산 타입별 연관된 색상 입히기](https://github.com/ericKwon95/PortfolioApp/pull/2)**
3. **[쫀득한 스크롤 만들기](https://github.com/ericKwon95/PortfolioApp/pull/3)**

## 파일 트리
```
Aim-Portfolio
├── Aim-Portfolio
│   ├── App
│   │   ├── Aim_PortfolioApp.swift
│   │   └── SplashView.swift
│   ├── Preview Content
│   │   └── Preview Assets.xcassets
│   │       └── Contents.json
│   ├── Resource
│   │   ├── Assets.xcassets
│   │   │   ├── AccentColor.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── AllStockBackground.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── AppBackground.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── AppIcon.appiconset
│   │   │   │   └── Contents.json
│   │   │   ├── AppPrimary.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── AssetTypeTitle.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── Bond.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── Contents.json
│   │   │   ├── Etc.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── RatioBarBackground.colorset
│   │   │   │   └── Contents.json
│   │   │   └── Stock.colorset
│   │   │       └── Contents.json
│   │   └── testFile.json
│   └── Source
│       ├── Coordinator
│       │   ├── Coordinator.swift
│       │   └── Destination.swift
│       ├── Extensions
│       │   ├── Color+AdjustBrightness.swift
│       │   ├── String+SplitWord.swift
│       │   └── View+HideKeyboard.swift
│       ├── Manager
│       │   ├── JSONLoader
│       │   │   └── JSONLoader.swift
│       │   └── Validator
│       │       ├── ValidationResult.swift
│       │       └── Validator.swift
│       ├── Model
│       │   ├── AssetDTO.swift
│       │   ├── AssetItem.swift
│       │   └── User.swift
│       ├── View
│       │   ├── AllStocksView.swift
│       │   ├── Common
│       │   │   ├── AssetRatioView.swift
│       │   │   ├── DonutChart.swift
│       │   │   ├── InputTextView.swift
│       │   │   ├── RatioBar.swift
│       │   │   └── StockRow.swift
│       │   ├── MainView.swift
│       │   ├── SignUpView.swift
│       │   └── UIViewRepresentable
│       │       └── SecureTextFieldRepresentable.swift
│       └── ViewModel
│           ├── PortfolioViewModel.swift
│           ├── RefineViewModel.swift
│           └── SignUpViewModel.swift
├── Aim-Portfolio.xcodeproj
│   ├── project.pbxproj
│   ├── project.xcworkspace
│   │   ├── contents.xcworkspacedata
│   │   ├── xcshareddata
│   │   │   └── swiftpm
│   │   │       └── configuration
│   │   └── xcuserdata
│   │       └── erickwon.xcuserdatad
│   │           └── UserInterfaceState.xcuserstate
│   └── xcuserdata
│       └── erickwon.xcuserdatad
│           ├── xcdebugger
│           │   └── Breakpoints_v2.xcbkptlist
│           └── xcschemes
│               └── xcschememanagement.plist
├── Aim-PortfolioTests
│   └── Aim_PortfolioTests.swift
└── Aim-PortfolioUITests
    ├── Aim_PortfolioUITests.swift
    └── Aim_PortfolioUITestsLaunchTests.swift
```


## 커밋 컨벤션
커밋 컨벤션은 Udacity Git Commit Message Style Guide 를 따릅니다.

```
feat: A new feature
fix: A bug fix
docs: Changes to documentation
style: Formatting, missing semi colons, etc; no code change
refactor: Refactoring production code
test: Adding tests, refactoring test; no production code change
chore: Updating build tasks, package manager configs, etc; no production code change
```
