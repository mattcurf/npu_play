import torch
from efficientnet_pytorch import EfficientNet

model = EfficientNet.from_pretrained('efficientnet-b4')
dummy_input = torch.randn(10, 3, 384, 380)

model.set_swish(memory_efficient=False)
torch.onnx.export(model, dummy_input, "efficientnet-b4.onnx", verbose=True)

