defmodule Classification.Resnet do
  def build_model() do
    {:ok, model_info} = Bumblebee.load_model({:hf, "microsoft/resnet-50"})
    {:ok, featurizer} = Bumblebee.load_featurizer({:hf, "microsoft/resnet-50"})

    Bumblebee.Vision.image_classification(
      model_info,
      featurizer,
      top_k: 1,
      compile: [batch_size: 10],
      defn_options: [compiler: EXLA]
    )
  end
end
