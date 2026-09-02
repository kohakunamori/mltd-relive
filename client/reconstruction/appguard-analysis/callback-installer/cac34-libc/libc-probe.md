# `cac34` libc / pthread_once differential probe

| variant | w0 | bit0 | instructions | once initializers | error |
|---|---:|---:|---:|---:|---|
| `baseline` | `0x0` | False | 1183969 | 0 | |
| `locale-ascii` | `0x0` | False | 1183969 | 0 | |
| `pthread_once-execute` | `0x0` | False | 1183999 | 2 | |
| `locale+once` | `0x0` | False | 1183999 | 2 | |

## pthread_once initializers

### `baseline`

### `locale-ascii`

### `pthread_once-execute`
- control `0x1020d560` -> init `+0xea414`, caller/return `+0xea804`
- control `0x1020d580` -> init `+0xe8464`, caller/return `+0xe8adc`

### `locale+once`
- control `0x1020d560` -> init `+0xea414`, caller/return `+0xea804`
- control `0x1020d580` -> init `+0xe8464`, caller/return `+0xe8adc`

