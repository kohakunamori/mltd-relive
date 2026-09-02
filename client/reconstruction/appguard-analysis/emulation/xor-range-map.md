# AppGuard protected-range XOR map

- stop: `instruction limit 12000000`
- instructions: **12000001**
- parsed descriptors: **25**
- observed key copies: **1**
- observed decrypted ranges: **1**

## Observed decrypt ranges

| start | descriptor end | size | ops | offset span | key16 | key source | descriptor word3 |
|---:|---:|---:|---:|---|---|---|---:|
| `0x4d1d0` | `0x521fc` | `0x502c` | 20512 | `0x0..0x501f` | `a80300b008d18db9c90300d029e12291` | `libcompatible:0x1712a8` | `0xeb09025fe7d08d99` |

## Descriptor table

| mmap + | start | end | size | word3 | observed key |
|---:|---:|---:|---:|---:|---|
| `0x2000` | `0x189c` | `0x6a70` | `0x51d4` | `0xb90005cf00000000` | `-` |
| `0x2020` | `0x13298` | `0x14fdc` | `0x1d44` | `0x5400008c89b90c7d` | `-` |
| `0x2040` | `0x14fdc` | `0x1b660` | `0x6684` | `0xb8637812b9ca5797` | `-` |
| `0x2060` | `0x7080c` | `0x70d30` | `0x524` | `0x54ffff0c2e50cbcf` | `-` |
| `0x2080` | `0x1b660` | `0x4d1d0` | `0x31b70` | `0xb82c680df36e7bd1` | `-` |
| `0x20a0` | `0x1712a8` | `0x171878` | `0x5d0` | `0x8b05080f272245f7` | `-` |
| `0x20c0` | `0x4d1d0` | `0x521fc` | `0x502c` | `0xeb09025fe7d08d99` | `a80300b008d18db9c90300d029e12291` |
| `0x20e0` | `0x521fc` | `0x7080c` | `0x1e610` | `0x8b048172054425ad` | `-` |
| `0x2100` | `0x14de18` | `0x14dffc` | `0x1e4` | `0x6b0f007fc49ec2e9` | `-` |
| `0x2120` | `0x14e01c` | `0x15632c` | `0x8310` | `0xb82c680d50500375` | `-` |
| `0x2140` | `0x15632c` | `0x157548` | `0x121c` | `0x8b05080f555a44c5` | `-` |
| `0x2160` | `0x157548` | `0x158974` | `0x142c` | `0xeb09025ffac34249` | `-` |
| `0x2180` | `0x158974` | `0x15aab4` | `0x2140` | `0x8b0481726f30ee22` | `-` |
| `0x21a0` | `0x15aab4` | `0x15ab90` | `0xdc` | `0x6b0f007f2c2955a1` | `-` |
| `0x21c0` | `0x14dffc` | `0x14e01c` | `0x20` | `0xb82c680df625103a` | `-` |
| `0x21e0` | `0x16fb3c` | `0x16fbb8` | `0x7c` | `0x8b05080f3e372e40` | `-` |
| `0x2200` | `0x1408b8` | `0x14be58` | `0xb5a0` | `0xeb09025ff484b2bf` | `-` |
| `0x2220` | `0x133014` | `0x1374b8` | `0x44a4` | `0x8b0481720ca46306` | `-` |
| `0x2240` | `0x1610f0` | `0x16fb3c` | `0xea4c` | `0x6b0f007f0101befa` | `-` |
| `0x2260` | `0x1374b8` | `0x1408b8` | `0x9400` | `0xb82c680d2dfda1f4` | `-` |
| `0x2280` | `0x14d820` | `0x14de18` | `0x5f8` | `0x8b05080f30366f7e` | `-` |
| `0x22a0` | `0x15bd84` | `0x15ea3c` | `0x2cb8` | `0xeb09025f60dac641` | `-` |
| `0x22c0` | `0x15ab90` | `0x15bd84` | `0x11f4` | `0x8b048172ca47a9e2` | `-` |
| `0x22e0` | `0x15ea3c` | `0x1610f0` | `0x26b4` | `0x6b0f007f9daf858a` | `-` |
| `0x2300` | `0x1320bc` | `0x133014` | `0xf58` | `0xb82c680d38b12d3b` | `-` |

## Raw key-copy events

| instruction | target | source | source class | key16 |
|---:|---:|---:|---|---|
| 2033156 | `0x4d1d0` | `0x101712a8` | `libcompatible:0x1712a8` | `a80300b008d18db9c90300d029e12291` |
