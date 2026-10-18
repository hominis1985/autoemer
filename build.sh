#!/bin/sh
# app.html(본문) → index.html(설치형 PWA) 생성
cd "$(dirname "$0")"
{
cat <<'H'
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
<meta name="theme-color" content="#f5a300">
<link rel="manifest" href="manifest.webmanifest">
<link rel="icon" href="icon.svg" type="image/svg+xml">
<link rel="apple-touch-icon" href="icon.svg">
<meta name="apple-mobile-web-app-capable" content="yes">
<style>:root{padding-top:env(safe-area-inset-top,0px)}body{margin:0}[hidden]{display:none!important}</style>
H
sed -n '1,/^<\/style>/p' app.html
echo '</head>'
echo '<body>'
sed -n '/^<\/style>/,$p' app.html | tail -n +2
cat <<'F'
<script>if("serviceWorker" in navigator){addEventListener("load",()=>navigator.serviceWorker.register("sw.js").catch(()=>{}));}</script>
</body>
</html>
F
} > index.html
