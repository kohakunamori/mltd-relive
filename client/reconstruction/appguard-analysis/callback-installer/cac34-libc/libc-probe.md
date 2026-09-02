# `cac34` libc / pthread_once differential probe

| variant | w0 | bit0 | instructions | once initializers | error |
|---|---:|---:|---:|---:|---|
| `baseline` | - | - | - | - | `KeyError: 'UC_ARM64_REG_X2'` |
| `locale-ascii` | - | - | - | - | `KeyError: 'UC_ARM64_REG_X2'` |
| `pthread_once-execute` | - | - | - | - | `KeyError: 'UC_ARM64_REG_X2'` |
| `locale+once` | - | - | - | - | `KeyError: 'UC_ARM64_REG_X2'` |

## pthread_once initializers

