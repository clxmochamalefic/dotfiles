-- blade ファイルにおける % ジャンプのエラーを修正する
--
-- 問題の原因:
--   matchit が blade ファイルで使用する b:match_words に不適切なパターンが
--   設定されている（または未設定）ため、% を押すとエラーになる / ジャンプ不可。
--   HTML ftplugin 由来の複雑なパターンは blade 固有構文 ({{ }}, {!! !!} 等) で
--   catastrophic backtracking を起こす場合がある。
--
-- 対策:
--   after/ftplugin/blade.lua で b:match_words を blade 向けの安全なパターンに
--   上書きし、Blade ディレクティブ間のジャンプ (@if ↔ @endif 等) も追加する。

-- HTML タグのジャンプ
-- [^>]* を使うことで > が出現した時点で停止し backtracking が発生しない
-- (HTML ftplugin の [^>]*[^/]> と違い、blade 式の中に > があっても安全)
local html_comment = "<!--:-->"
local html_tags    = "<\\(\\w\\+\\)[^>]*>:<\\/\\1>"

-- Blade ディレクティブのマッチペア (@if ↔ @elseif ↔ @else ↔ @endif 等)
-- @for\> は word 境界で終端させることで @foreach / @forelse との誤マッチを防ぐ
local blade_pairs = table.concat({
  "@if:@elseif:@else:@endif",
  "@unless:@endunless",
  "@foreach:@endforeach",
  "@forelse:@empty:@endforelse",
  "@for\\>:@endfor",
  "@while:@endwhile",
  "@switch:@endswitch",
  "@isset:@endisset",
  "@auth:@endauth",
  "@guest:@endguest",
  "@section:@show:@endsection",
  "@push:@endpush",
  "@prepend:@endprepend",
  "@component:@endcomponent",
  "@slot:@endslot",
  "@verbatim:@endverbatim",
  "@once:@endonce",
  "@php:@endphp",
  -- lsp.lua の blade_custom_directives_pairs に合わせたカスタムペア
  "@markdown:@endmarkdown",
  "@cache:@endcache",
}, ",")

vim.b.match_words = html_comment .. "," .. html_tags .. "," .. blade_pairs
