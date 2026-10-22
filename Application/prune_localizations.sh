#!/bin/sh
# 빌드된 Dopamine.app 안에서 en.lproj, ko.lproj(및 Base.lproj)를 제외한
# 나머지 언어팩(*.lproj)을 삭제합니다. 서명(ldid) 전에 실행해야 합니다.
#
# 사용법: ./prune_localizations.sh <Dopamine.app 경로>

set -e

APP_PATH="$1"
KEEP="en.lproj ko.lproj Base.lproj"

if [ -z "$APP_PATH" ] || [ ! -d "$APP_PATH" ]; then
    echo "prune_localizations: .app 경로를 찾을 수 없습니다: $APP_PATH" >&2
    exit 1
fi

removed=0
for dir in "$APP_PATH"/*.lproj; do
    [ -d "$dir" ] || continue
    name=$(basename "$dir")
    case " $KEEP " in
        *" $name "*) continue ;;
    esac
    rm -rf "$dir"
    removed=$((removed + 1))
done

echo "prune_localizations: 불필요한 언어팩 ${removed}개 삭제 (유지: $KEEP)"
