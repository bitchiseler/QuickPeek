# QuickPeek - macOS 이미지 뷰어

QuickPeek는 macOS와 Apple CPU에서 동작하는 간단하고 빠른 이미지 뷰어입니다.

## 주요 기능

- 다양한 이미지 형식 지원: jpg, jpeg, png, gif, bmp, webp
- ZIP 파일 내 이미지 뷰잉
- 직관적인 단축키 지원
- 파일 정보 표시
- 드래그 앤 드롭 지원

## 단축키

| 단축키 | 기능 |
|--------|------|
| Tab | 메뉴 표시/숨기기 |
| d | 이미지 전환 방향 바꾸기 (좌->우 / 우->좌) |
| ~ | 화면 좌측 상단에 파일 정보 띄우기 |
| 좌/위 방향키 | 이전 이미지 |
| 우/아래 방향키, Spacebar | 다음 이미지 |
| [ | 이전 이미지 (ZIP 모드: 이전 ZIP 파일) |
| ] | 다음 이미지 (ZIP 모드: 다음 ZIP 파일) |
| ESC | 앱 종료 |
| Cmd+O | 파일 열기 |

## ZIP 파일 처리

QuickPeek는 ZIP 파일 내의 이미지를 직접 볼 수 있습니다.

- ZIP 파일을 열면 내부의 이미지 파일들이 자동으로 로드됩니다.
- ZIP 파일에 이미지가 없는 경우, 다음 ZIP 파일을 자동으로 열어봅니다.
- ZIP 모드에서 `[`와 `]` 키를 사용하여 ZIP 파일 간에 이동할 수 있습니다.

## 시스템 요구사항

- macOS 26.0 이상
- Apple Silicon (M1/M2/M3) 또는 Intel Mac

## 설치 및 실행

1. 이 저장소를 클론합니다:
   ```
   git clone [repository-url]
   ```

2. Xcode에서 프로젝트를 엽니다:
   ```
   open QuickPeek.xcodeproj
   ```

3. Xcode에서 빌드하고 실행합니다 (Cmd+R).

## 사용법

1. 앱을 실행합니다.
2. "파일 열기" 버튼을 클릭하거나 `Cmd+O`를 눌러 이미지를 엽니다.
3. 이미지 파일을 앱 창으로 드래그 앤 드롭할 수도 있습니다.
4. 단축키를 사용하여 이미지를 탐색합니다.

## 개발

QuickPeek는 SwiftUI로 개발되었으며, 다음 주요 기술을 사용합니다:

- SwiftUI: 사용자 인터페이스
- UniformTypeIdentifiers: 파일 형식 식별
- Foundation: 파일 시스템 및 ZIP 처리

## 라이선스

[라이선스 정보]
