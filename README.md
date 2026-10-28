# art_chain

**One capability bit from GBT V8, packaged standalone.** No. 12 of 341,
`creation` domain (Creation).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> **作品链**（一条命令：挑组件 → 取件 → **真渲** → 调优，每步带读数）。① `ui_kit.find(q)` 挑头一件（带外链数）② `ui_kit.take` 拷进 `outputs/art-chain/`③ 调 `render_page.py` **真 Chromium 渲**（该件自带禁网 + 逐条记拦获）④ `vision_print.polish` 清晰度+补光。常用说法：出作品 / 挑组件出图 / 一键出图 / 拿这个组件做张图。旋钮：`q`(人话) · `look`(味道，**默认「原样」= 只调旋钮不套味道**) · `size` · `sharpen` · `grain` · `grade_fmt`(.png 无损)。铁律：每步走**既有门/既有件**（不重写渲染器、不绕门）· 失败**停在原地并说清哪一步**（不把半成品念成作品）· 上游 `_upstream/galaxy/**` 一个字节不动。

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-art-chain.git
cd gbt-art-chain
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_art_chain info                  # capability card
python -m gbt_art_chain spec --json           # machine-readable contract
python -m gbt_art_chain check --payload '{}'
python -m gbt_art_chain run   --payload '{}'
```

Real `info` output from this machine:

```text
art_chain  (creation)  v1.0.0
----------------------------------------
**作品链**（一条命令：挑组件 → 取件 → **真渲** → 调优，每步带读数）。① `ui_kit.find(q)` 挑头一件（带外链数）② `ui_kit.take` 拷进 `outputs/art-chain/`③ 调 `render_page.py` **真 Chromium 渲**（该件自带禁网 + 逐条记拦获）④ `vision_print.polish` 清晰度+补光。常用说法：出作品 / 挑组件出图 / 一键出图 / 拿这个组件做张图。旋钮：`q`(人话) · `look`(味道，**默认「原样」= 只调旋钮不套味道**) · `size` · `sharpen` · `grain` · `grade_fmt`(.png 无损)。铁律：每步走**既有门/既有件**（不重写渲染器、不绕门）· 失败**停在原地并说清哪一步**（不把半成品念成作品）· 上游 `_upstream/galaxy/**` 一个字节不动。

gated      : True   <- needs explicit consent
external   : False
multi-op   : False
params     : (none)
```

Wire a real implementation:

```python
from gbt_art_chain import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Gated: this bit is marked `safe: false` in the registry — it can change state that no inverse action restores.
- No external service dependency declared.
- Single-action bit.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.11s
```

## Provenance

| field | value |
|---|---|
| capability | `art_chain` |
| domain | `creation` |
| handler | `art_chain` |
| safe | `False` (gated = `True`) |
| external | `False` |
| atlas page | [creation/art_chain](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/creation/art_chain.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
