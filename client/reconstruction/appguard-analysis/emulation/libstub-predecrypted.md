# AppGuard libstub stage with offline pre-decrypted libcompatible ranges

- bootstrap stop: `libcompatible loader callback ready`
- callback captured: **True**

## Offline range transforms

| range | key source | key16 | xor bytes | remainder | before SHA | after SHA |
|---|---:|---|---:|---:|---|---|
| `0x1b660..0x4d1d0` | `0x7080c` | `a80b00d008d18db9c90b00f029e12291` | 203632 | 0 | `7abdb0514bfca1e908ea124cf92d5324b8e604a940b748661d16bb437fd47808` | `b2250ff2c6be56fc488055331559cb6517794a5e8c65f5f4027acbc9d4f134fb` |
| `0x4d1d0..0x521fc` | `0x1712a8` | `a80300b008d18db9c90300d029e12291` | 20512 | 12 | `4c14838ab64b90c6e4650fc5b5119c3e20ec2501af9ba97e9fe90056594bba8c` | `d8c5c2f017a56b410f8d7f83548a2e6ea5cb72aa3c3d0e3e670c416875f20686` |

## SoLibraryStart -> libstub result

- stop: `unsupported direct syscall 0 at 0x0`
- instructions: **652**
- libstub bytes changed: **0**
- observed libstub writes: **0**
- weak encrypted libstub SoLibraryStart changed: **False**

### External calls reached

- `__errno` args=`[347892359168, 269299712, 3, 34, 18446744073709551615, 0, 0, 3813734331]` string=``
- `madvise` args=`[347892359168, 4096, 12, 34, 18446744073709551615, 0, 0, 3813734331]` string=``
- `pthread_mutex_lock` args=`[270457848, 4096, 12, 34, 18446744073709551615, 0, 0, 3813734331]` string=``
- `malloc` args=`[48, 270457808, 270083035, 481053085504, 481053085496, 0, 0, 3813734331]` string=``
- `pthread_mutex_unlock` args=`[270457848, 343597392784, 270457808, 270457808, 481053085496, 0, 0, 3813734331]` string=``

### Direct exception/syscall events

- pc=`0x100d38b4` intno=2 nr=`226` name=`mprotect` args=`[0, 0, 7, 481053085632, 481053085628, 226]`
- pc=`0x100d38b4` intno=2 nr=`222` name=`mmap` args=`[0, 4096, 3, 34, 18446744073709551615, 0]`
- pc=`0x0` intno=1 nr=`0` name=`sys_0` args=`[536961024, 0, 0, 3422691221, 3100069432, 539041771]`

### Modified libstub ranges

- none
