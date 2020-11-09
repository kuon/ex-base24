defmodule Base24.MixProject do
  use Mix.Project

  def project do
    [
      app: :base24,
      version: "0.1.1",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      name: "Base24",
      source_url: "https://git.goyman.com/kuon/ex-base24"
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end


  defp description() do
    "An encoder/decoder for base24 binary-to-text encoding"
  end

  defp package() do
    [
      licenses: ["Apache-2.0", "MIT"],
      links: %{"GitHub" => "https://github.com/kuon/ex-base24"}
    ]
  end
end
