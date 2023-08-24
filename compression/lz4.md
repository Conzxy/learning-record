# Frame Format
* LZ4 compressoin method
* (optional)xxHash checksum, detect data corruption

## Structure(Fields)
### LZ4 Frame Header
#### Magic number: 4 bytes(LE), value is `0x184d2204`
#### Frame Descriptor: 3-15 bytes.

### Data Block
Store the compressed data.

### LZ4 Frame Foot
#### EndMask
The last data block has `0x00000000` value.

#### Content checksum
Use xxHash-32 version API with 0 as the seed to compute the result.
This is optional, only enabled when flag in FD has set.

# Block Format
主要是给基于LZ4压缩数据的开发者使用的，开发者可以根据自己的需求定制不同于Frame Format的其他数据格式。

采用这种原生格式(相比Frame)主要是为了简单和速度。

