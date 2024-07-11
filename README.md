## last-command-for-Windows
Unix last와 유사한 기능을 Windows에서 구현합니다.  
Windows EventLog 기반 로그온/오프 기록 표시  
[Updates](./version_log.md)

> [!NOTE]
> encoding: EUC-KR  
> line break: CSLF  

> [!WARNING]
> _batch command로 작성되었기 때문에 이벤트 로그의 양에 비례하여 속도가 느려집니다._  
> ~~이벤트 로그를 지우면 빨라진다!~~

## Installation
`last_installer.bat` 관리자 권한으로 실행
```cmd
last_installer.bat
or
start last_installer.bat
```
> **Requirements**
> - Windows NT or above

## Usage
last 사용법
```cmd
Options:
     --on          로그온 목록만 표시
     --off         로그오프 목록만 표시
  -A --all         로그온/오프 목록 표시 [기본값]
  -O               날짜/시간순으로 정렬 [기본값: -O:A]
     --order:D     D  내림차순(가장 최신 항목부터)
     --order:A     A  오름차순(가장 오래된 항목부터)
  -V --version     버전 확인
  -h --help        도움말 표시(현재 창 표시)
```

#### 이벤트 로그 일괄 삭제(사용 시 주의)
[`rmevt.bat`](./production/rmevt.bat) 관리자 권한으로 실행  
**❗ Windows에 모든 이벤트를 삭제합니다. 이벤트 로그가 중요한 환경에서는 실행 권장 안 함.**  
아래 명령어와 동일(CLI 환경)
```cmd
for /f %i in ('wevtutil el') do wevtutil cl "%i"
```

#### 로그온 목록을 내림차순으로 출력
e.g.
```cmd
last --on -O:D
or
last --on -order:D
```

## License
See the [LICENSE](./LICENSE) file for license rights and limitations (MIT).