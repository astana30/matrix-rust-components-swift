#!/bin/bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "usage: $0 <MatrixSDKFFI.xcframework>" >&2
    exit 64
fi

xcframework_path=$1
if [[ ! -d "$xcframework_path" || -L "$xcframework_path" ]]; then
    echo "error: XCFramework must be a directory, not a symlink" >&2
    exit 65
fi

xcframework_path=$(cd "$xcframework_path" && pwd -P)
info_plist="$xcframework_path/Info.plist"
if [[ ! -f "$info_plist" || -L "$info_plist" ]]; then
    echo "error: XCFramework Info.plist is missing or invalid" >&2
    exit 66
fi

library_count=$(/usr/bin/plutil -extract AvailableLibraries raw -o - "$info_plist")
if [[ ! "$library_count" =~ ^[0-9]+$ || "$library_count" -eq 0 ]]; then
    echo "error: XCFramework has no library entries" >&2
    exit 67
fi

for ((index = 0; index < library_count; index++)); do
    identifier=$(/usr/bin/plutil -extract "AvailableLibraries.$index.LibraryIdentifier" raw -o - "$info_plist")
    headers_path=$(/usr/bin/plutil -extract "AvailableLibraries.$index.HeadersPath" raw -o - "$info_plist")
    module_root="$xcframework_path/$identifier/Headers/MatrixSDKFFI"

    if [[ "$headers_path" != "Headers" && "$headers_path" != "Headers/MatrixSDKFFI" ]]; then
        echo "error: unexpected HeadersPath" >&2
        exit 68
    fi

    if [[ ! -d "$module_root" || -L "$module_root" || ! -f "$module_root/module.modulemap" ]]; then
        echo "error: MatrixSDKFFI module root is missing or invalid" >&2
        exit 69
    fi

    /usr/bin/plutil -replace "AvailableLibraries.$index.HeadersPath" \
        -string "Headers/MatrixSDKFFI" "$info_plist"
done

/usr/bin/plutil -lint "$info_plist" >/dev/null

for ((index = 0; index < library_count; index++)); do
    identifier=$(/usr/bin/plutil -extract "AvailableLibraries.$index.LibraryIdentifier" raw -o - "$info_plist")
    headers_path=$(/usr/bin/plutil -extract "AvailableLibraries.$index.HeadersPath" raw -o - "$info_plist")
    if [[ "$headers_path" != "Headers/MatrixSDKFFI" || ! -f "$xcframework_path/$identifier/$headers_path/module.modulemap" ]]; then
        echo "error: corrected header exposure validation failed" >&2
        exit 70
    fi
done
