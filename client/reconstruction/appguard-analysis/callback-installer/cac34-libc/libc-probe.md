# `cac34` libc / pthread_once differential probe

| variant | w0 | bit0 | instructions | once initializers | error |
|---|---:|---:|---:|---:|---|
| `baseline` | - | - | - | - | `UcError: Invalid memory write (UC_ERR_WRITE_UNMAPPED)` |
| `locale-ascii` | - | - | - | - | `UcError: Invalid memory write (UC_ERR_WRITE_UNMAPPED)` |
| `pthread_once-execute` | - | - | - | - | `UcError: Invalid memory write (UC_ERR_WRITE_UNMAPPED)` |
| `locale+once` | - | - | - | - | `UcError: Invalid memory write (UC_ERR_WRITE_UNMAPPED)` |

## pthread_once initializers

