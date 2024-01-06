defmodule SevenMind.Ash.Extensions.JsonEncoder do
  use Spark.Dsl.Extension, transformers: [SevenMind.Ash.Extensions.Transformers.DeriveJsonEncoder]
end
