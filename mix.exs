defmodule Haveibeenpwned.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :haveibeenpwned,
      version: @version,
      elixir: "~> 1.7.4",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      description: description(),
      package: package(),
      compilers: [:rustler] ++ Mix.compilers(),
      rustler_crates: rustler_crates(),
      source_url: "https://github.com/team-alembic/haveibeenpwned"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [mod: {Haveibeenpwned.Application, []}, extra_applications: [:logger]]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:download, "~> 0.0.4", github: "lukerollans/download"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:rustler, "~> 0.18.0"},
      {:benchee, "~> 0.13", only: :dev}
    ]
  end

  defp docs() do
    [
      main: "readme",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/haveibeenpwned",
      source_url: "https://github.com/team-alembic/haveibeenpwned",
      extras: ["README.md"]
    ]
  end

  defp description() do
    "Elixir package to check passwords against Troy Hunts haveibeenpwned database locally"
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/team-alembic/haveibeenpwned"}
    ]
  end

  defp rustler_crates do
    [
      nifread: [path: "native/nifread", mode: if(Mix.env() == :prod, do: :release, else: :debug)]
    ]
  end
end
