from pathlib import Path
import openvino as ov

core = ov.Core()

# create a directory for resnet model file
MODEL_DIRECTORY_PATH = Path("model")
MODEL_DIRECTORY_PATH.mkdir(exist_ok=True)

model_name = "resnet50"
from torchvision.models import resnet50, ResNet50_Weights

# create model object
pytorch_model = resnet50(weights=ResNet50_Weights.DEFAULT)

# switch model from training to inference mode
pytorch_model.eval();

precision = "FP16"
model_path = MODEL_DIRECTORY_PATH / "ir_model" / f"{model_name}_{precision.lower()}.xml"

model = None
if not model_path.exists():
  model = ov.convert_model(pytorch_model, input=[[1, 3, 224, 224]])
  ov.save_model(model, model_path, compress_to_fp16=(precision == "FP16"))
  print("IR model saved to {}".format(model_path))

