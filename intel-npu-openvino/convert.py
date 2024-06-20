import sys
from pathlib import Path

src_filename = Path(sys.argv[1])
dst_filename = src_filename.with_suffix('.xml')
print(src_filename)
print(dst_filename)

import openvino as ov
ov_model = ov.convert_model(src_filename)
ov.save_model(ov_model, dst_filename) 

